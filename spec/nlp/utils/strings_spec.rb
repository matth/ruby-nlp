require "spec_helper"
require "csv"

describe NLP::Utils::Strings do

  include NLP::Utils::Strings

  describe ".min_edit_distance" do

    it "should calculate minimum edit distance correctly when one sting is empty" do
      min_edit_distance("hello", "").should == 5
      min_edit_distance("", "goodbye").should == 7
    end

    it "should calculate minimum edit distance correctly" do

      CSV.foreach("spec/fixtures/min_edit_distance_data.csv", :headers => true) do |line|

        string_a     = line["string_a"]
        string_b     = line["string_b"]
        distance     = line["minimum_edit_distance"].to_i

        min_edit_distance(string_a, string_b).should == distance
        min_edit_distance(string_b, string_a).should == distance

      end

    end

  end

end
