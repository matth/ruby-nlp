require "spec_helper"

describe NLP::NgramIndex do

  it "should store n-gram frequencies up to size n" do

    next

    index = NLP::NgramIndex.new(3)

    index.add(["foo", "bar", "baz", "bip"])
    index.add(["foo", "bar", "baz"])
    index.add(["foo", "bar"])
    index.add(["foo"])

    index.freq(["foo"]).should == 4
    index.freq(["foo", "bar"]).should == 3
    index.freq(["foo", "bar", "baz"]).should == 2
    index.freq(["foo", "bar", "baz", "bip"]).should == 0

  end

  describe ".extract" do

    it "should extract and store the frequency of all n-grams between 1 and n" do

      text = %W{
        Those hours that with gentle work did frame
        The lovely gaze where every eye doth dwell
        Will play the tyrants to the very same,
        And that unfair which fairly doth excel:
        For never-resting time leads summer on
        To hideous winter and confounds him there,
        Sap checked with frost and lusty leaves quite gone,
        Beauty o'er-snowed and bareness every where:
        Then were not summer's distillation left
        A liquid prisoner pent in walls of glass,
        Beauty's effect with beauty were bereft,
        Nor it nor no remembrance what it was.
        But flowers distilled though they with winter meet,
        Leese but their show, their substance still lives sweet.
      }

      index = NLP::NgramIndex.extract(5, text)

      index.freq(%W{ their substance }).should == 1
      index.freq(%W{ Nor it }).should == 1
      index.freq(%W{ the }).should == 2
      index.freq(%W{ To hideous winter and confounds }).should == 1

    end

  end

end