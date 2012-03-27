require "spec_helper"

describe NLP::Utils do

  include NLP::Utils

  describe ".ngrams" do
    it "should parse a sequencne into 'n' grams" do
      ngrams([1,2,3,4,5], 2).should == [[1, 2], [2, 3], [3, 4], [4, 5]]
    end
    it "should pad sequence with padding param" do
      ngrams([1,2,3,4,5], 2, nil).should == [[1, 2], [2, 3], [3, 4], [4, 5], [5, nil]]
      ngrams([1,2,3,4,5], 3, nil).should == [[1, 2, 3], [2, 3, 4], [3 ,4, 5], [4, 5, nil], [5, nil, nil]]
    end
  end

  describe ".bigrams" do
    it "should parse a sequencne into bigrams" do
      bigrams([1,2,3,4,5]).should == [[1, 2], [2, 3], [3, 4], [4, 5]]
    end
  end

  describe ".trigrams" do
    it "should parse a sequence into bigrams" do
      trigrams([1,2,3,4,5]).should == [[1, 2, 3], [2, 3, 4], [3 ,4, 5]]
    end
  end

end
