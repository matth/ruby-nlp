require 'spec_helper'

describe NLP::Classifiers::NaiveBayes do

  def training_data
    [
      [ :china, "Chinese Beijing Chinese" ],
      [ :china, "Chinese Chinese Shanghai" ],
      [ :china, "Chinese Macao" ],
      [ :japan, "Tokyo Japan Chinese" ]
    ]
  end

  def test_data
    "Chinese Chinese Chinese Tokyo Japan"
  end

  def train_and_run_classifier(classifier)
    training_data.each do |klass, text|
      classifier.train(klass, text.split(" "))
    end

    classifier.apply test_data.split(" ")
  end

  describe NLP::Classifiers::NaiveBayes::Multinomial do
    it "should classify the document correctly and return the correct probability" do

      results = train_and_run_classifier NLP::Classifiers::NaiveBayes::Multinomial.new

      results.first[:class].should == :china
      results.first[:score].should == -8.10769031284391

      results[1][:class].should == :japan
      results[1][:score].should == -8.906681345001262

    end
  end

  describe NLP::Classifiers::NaiveBayes::Bernoulli do
    it "should classify the document correctly and return the correct probability" do

      results = train_and_run_classifier NLP::Classifiers::NaiveBayes::Bernoulli.new

      results.first[:class].should == :japan
      results.first[:score].should == -3.8190850097688767

      results[1][:class].should == :china
      results[1][:score].should == -5.262178319932164

    end
  end

end