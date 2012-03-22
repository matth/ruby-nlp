require "spec_helper"

describe NLP::Stemmers::Levenshtein do

  def lev_test(a, b, dist)
    NLP::Stemmers::Levenshtein.distance(a,b).should == dist
    NLP::Stemmers::Levenshtein.distance(b,a).should == dist
  end

  it "should calculate Levenshtein distance" do
    lev_test "intention", "execution", 8
    lev_test "deem", "demure", 4
    lev_test "feed", "food", 4
    lev_test "food", "foed", 2
    lev_test "food", "food", 0
  end

end
