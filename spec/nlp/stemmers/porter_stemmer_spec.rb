require "spec_helper"

describe NLP::Stemmers::PorterStemmer do

  def stemmer
    @stemmer ||= NLP::Stemmers::PorterStemmer
  end

  def test_stemming(original, expected)
    stemmer.stem(original).should == expected
  end

  it "should stem words correctly" do

    # Step1
    test_stemming("a", "a")
    test_stemming("to", "to")
    test_stemming("caresses", "caress")
    test_stemming("ponies", "poni")
    test_stemming("ties", "ti")
    test_stemming("caress", "caress")
    test_stemming("cats", "cat")

    # Step 2
    test_stemming("feed", "feed")
    test_stemming("agreed", "agree")
    # test_stemming("plastered", "plaster")
    # test_stemming("bled", "bled")
    # test_stemming("motoring", "motor")
    # test_stemming("sing", "sing")

  end

end

