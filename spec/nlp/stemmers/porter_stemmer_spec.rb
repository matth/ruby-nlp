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
    test_stemming("plastered", "plaster")
    test_stemming("bled", "bled")
    test_stemming("motoring", "motor")
    test_stemming("sing", "sing")

    # Step 2 cleanup
    test_stemming("conflated", "conflate")
    test_stemming("troubling", "trouble")
    test_stemming("sized", "size")
    test_stemming("hopping", "hop")
    test_stemming("tanned", "tan")
    test_stemming("falling", "fall")
    test_stemming("hissing", "hiss")
    test_stemming("fizzed", "fizz")
    test_stemming("failing", "fail")
    test_stemming("filing", "file")

    # Step 3
    test_stemming("happy", "happi")
    test_stemming("sky", "sky")

  end

end

