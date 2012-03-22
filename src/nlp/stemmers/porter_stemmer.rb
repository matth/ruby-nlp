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
          if measure > 1 && ends_with("eed")
            @word = @word[0..-2]
          end
        end

        def measure
          sounds.scan(/VC/).size
        end

        def sounds
          @word.size.times.reduce('') {|a,c| a += cons(c) ? 'C' : 'V'; a }
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