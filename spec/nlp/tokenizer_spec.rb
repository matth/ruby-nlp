require "spec_helper"

describe NLP::Tokenizer do

  describe NLP::Tokenizer do

    it "should read a word at a time" do
      contents  = "foo bar \nbaz"
      tokenizer = NLP::Tokenizer.new(contents)
      tokenizer.to_a.should == contents.split(" ")
    end

  end

end