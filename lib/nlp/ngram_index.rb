require 'nlp/utils'

module NLP

  class NgramIndex

    extend NLP::Utils

    def self.extract(max, tokens)
      index = self.new(max)
      ngrams(tokens, max, nil).each {|n| index.add n.compact }
      index
    end

    attr_reader :n, :root

    def initialize(n)
      @n    = n
      @root = Hash.new
    end

    def add(ngram)
      node = root
      ngram[0...n].each do |gram|
        node = node[gram] ||= { :count => 0 }
        node[:count] += 1
      end
    end

    def freq(ngram)
      node = root
      ngram.each do |gram|
        return 0 unless node = node[gram]
      end
      node[:count]
    end

  end

end
