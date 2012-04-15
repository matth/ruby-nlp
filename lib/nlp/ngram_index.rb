require 'nlp/utils'

module NLP

  class NgramIndex

    ##########################################################################
    # CLASS METHODS
    ##########################################################################

    extend NLP::Utils

    def self.extract(max, tokens)
      index = self.new(max)
      ngrams(tokens, max, nil).each {|n| index.add n.compact }
      index
    end

    ##########################################################################
    # WORD INDEX
    ##########################################################################

    class WordIndex < NLP::DataStructures::Trie

      def insert(word)
        @id_counter ||= 0
        if find(word).nil?
          super(word, @id_counter += 1)
          @id_counter
        else
          find(word)
        end

      end

      def find(word)
        super(word).values.first
      end

    end

    ##########################################################################
    # NGRAM FREQUENCY INDEX
    ##########################################################################

    class NgramFrequencyIndex < NLP::DataStructures::Trie

      def insert(ngram)
        if find(ngram).nil?
          super(ngram, 1)
        else
          cur_freq = find(ngram)
          delete_pair(ngram, cur_freq)
          super(ngram, cur_freq + 1)
        end
      end

      def find(ngram)
        super(ngram).values.first
      end

    end

    ##########################################################################
    # INSTANCE METHODS
    ##########################################################################

    attr_reader :n, :words, :ngrams

    def initialize(n)
      @n      = n
      @words  = WordIndex.new
      @ngrams = NgramFrequencyIndex.new
    end

    def add(ngram)
      word_ids = ngram[0...n].map { |w| words.insert(w) }
      ngrams.insert word_ids
    end

    def freq(ngram)
      word_ids = ngram[0...n].map { |w| words.find(w) }
      return 0 if word_ids.include? nil
      ngrams.find word_ids
    end

  end

end
