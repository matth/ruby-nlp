module NLP
  module Stemmers
    module PorterStemmer

      def self.stem(word)
        StemmableWord.new(word).to_s
      end

      class StemmableWord

        def initialize(word)
          @word = word
          unless word.size < 3
            step1
            step2
          end
        end

        def to_s
          @word
        end

        private

        def ends_with(string)
          to_s =~ /#{string}$/
        end

        def step1
          if ends_with("sses") || ends_with("ies")
            @word = @word[0..-3]
          elsif ends_with("s") && !ends_with("ss")
            @word = @word[0..-2]
          end
        end

        def step2
          if ends_with("eed")
            @word = @word[0..-2] if measure > 1
          elsif ends_with("ed")  && sounds_before(@word, "ed").include?("V")
            @word = @word[0..-3]
            step2_cleanup
          elsif ends_with("ing") && sounds_before(@word, "ing").include?("V")
            @word = @word[0..-4]
            step2_cleanup
          end
        end

        def step2_cleanup
          if ends_with("at") || ends_with("bl") || ends_with("iz")
            @word += "e"
          elsif sounds(@word)[-2,2] == "CC" && @word[-2,1] == @word[-1,1] && !(ends_with("l") || ends_with("s") || ends_with("z"))
            @word = @word[0..-2]
          elsif measure == 1 && sounds(@word)[-3,3] == "CVC" && !(ends_with("w") || ends_with("x") || ends_with("y"))
            @word += "e"
          end
        end

        def measure
          sounds(@word).scan(/VC/).size
        end

        def sounds(word)
          word.size.times.reduce('') {|a,c| a += cons(c) ? 'C' : 'V'; a }
        end

        def sounds_before(word, suffix)
          sounds word.gsub(/#{suffix}$/, "")
        end

        def cons(pos)
          case @word[pos]
            when 'a'
            when 'e'
            when 'i'
            when 'o'
            when 'u'
              false
            when 'y'
              pos == 0 ? true : !cons(pos - 1)
            else
              true
          end
        end

      end

    end
  end
end