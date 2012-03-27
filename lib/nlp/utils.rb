module NLP
  module Utils

    # Converts an enumerable object into n-grams
    #
    # @example Convert list to bigrams
    #   "ngrams([1,2,3,4,5], 2)" #=> [[1, 2], [2, 3], [3, 4], [4, 5]]
    #
    # @example Convert list to bigrams with padding
    #   "ngrams([1,2,3,4,5], 2, nil)" #=> [[1, 2], [2, 3], [3, 4], [4, 5], [5, nil]]
    #
    # @param [Enumerable] enumerable an enumerable object to be converted into ngrams
    # @param [Integer] n the 'n' in n-grams
    # @param [Object] padding an optional padding object
    # @return [Enumerable] a list of n-grams
    def ngrams(enumerable, n, padding = false)
      if padding != false
        p_length   = (n - 1) % enumerable.size
        enumerable = enumerable + [padding] * p_length
      end
      count = [0, enumerable.size - n + 1].max
      count.times.map { |i| enumerable[i...(i+n)] }
    end

    # Converts an enumerable object into bigrams
    #
    # @example
    #   "bigrams([1,2,3,4,5])" #=> [[1, 2], [2, 3], [3, 4], [4, 5]]
    #
    # @param [Enumerable] enumerable an enumerable object to be converted into bigrams
    # @return [Enumerable] a list of bigrams
    def bigrams(enumerable)
      ngrams(enumerable, 2)
    end

    # Converts an enumerable object into trigrams
    #
    # @example
    #   "trigrams([1,2,3,4,5])" #=> [[1, 2, 3], [2, 3, 4], [3, 4, 5]]
    #
    # @param [Enumerable] enumerable an enumerable object to be converted into trigrams
    # @return [Enumerable] a list of trigrams
    def trigrams(enumerable)
      ngrams(enumerable, 3)
    end


  end
end
