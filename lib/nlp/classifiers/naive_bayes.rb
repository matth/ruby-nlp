module NLP
  module Classifiers
    module NaiveBayes

      ##########################################################################
      # BERNOULLI CLASSIFIER
      ##########################################################################

      # A Naive Bayes Classifier based on the Bernoulli model
      #
      # This classifier is based on the Bernoulli algorithm supplied in
      # Christopher D. Manning, Prabhakar Raghavan and Hinrich Schütze,
      # Introduction to Information Retrieval, Cambridge University Press. 2008.
      #
      # @see { http://nlp.stanford.edu/IR-book/html/htmledition/text-classification-and-naive-bayes-1.html Text classification & Naive Bayes }
      #
      # @example
      #   classifier = NLP::Classifiers::NaiveBayes::Bernoulli.new
      #
      #   classifier.train(:china, %W{ Chinese Beijing Chinese })
      #   classifier.train(:china, %W{ Chinese Chinese Shanghai })
      #   classifier.train(:china, %W{ Chinese Macao })
      #   classifier.train(:japan, %W{ Tokyo Japan Chinese })
      #
      #   results = classifier.apply(%W{ Chinese Chinese Chinese Tokyo Japan })
      #
      #   results.first[:class] # => :japan
      #   results.first[:score] # => -3.8190850097688767
      #
      class Bernoulli

        def initialize
          @class_counts = Hash.new(0)
          @vocabularies = Hash.new
          @vocabulary   = Hash.new
        end

        # Train the classifier with a document and class type
        #
        # @example
        #   classifier.train(:china, %W{ Chinese Beijing Chinese })
        #
        # @param [Object] klass An identifier for the class type
        # @param [Enumerable] document The document to train on
        # @return [Nil]
        def train(klass, document)
          @class_counts[klass] += 1
          words = {}
          document.each do |word|
            @vocabulary[word] = true
            words[word] = true
          end
          words.keys.each do |word|
            (@vocabularies[klass] ||= Hash.new(0))[word] += 1
          end
        end

        # Apply the classifier to a new document
        #
        # @example
        #   classifier.apply(:china, %W{ Chinese Chinese Chinese Tokyo Japan })
        #
        #   #=> [
        #        { :class => :japan, :score => -3.8190 },
        #        { :class => :china, :score => -5.2621 }
        #       ]
        #
        # @param [Enumerable] document The document to classify
        # @return [Array] An ordered array of results, the top one will have the highest score
        def apply(document)

          # Extract terms from document
          terms = document.reduce({}) { |a,w| a[w] = true; a }

          # Get doc count
          doc_count = @class_counts.values.reduce(:+).to_f

          # Loop each class
          results = @vocabularies.keys.map do |klass|

            # Prior prob.
            score = Math.log( @class_counts[klass] / doc_count )

            # Loop all terms in vocabulary
            score = @vocabulary.keys.reduce(score) do |score, word|

              # Conditional prob
              cond_prob = (@vocabularies[klass][word] + 1) / ( @class_counts[klass] + 2 ).to_f

              if terms.key?(word)
                score += Math.log cond_prob
              else
                score += Math.log (1 - cond_prob)
              end

              score
            end

            { :class => klass, :score => score }

          end

          results.sort do |a, b|
            b[:score] <=> a[:score]
          end

        end

      end

      ##########################################################################
      # MULTINOMIAL CLASSIFIER
      ##########################################################################

      # A Naive Bayes Classifier based on the Multinomial model
      #
      # This classifier is based on the Multinomial algorithm supplied in
      # Christopher D. Manning, Prabhakar Raghavan and Hinrich Schütze,
      # Introduction to Information Retrieval, Cambridge University Press. 2008.
      #
      # @see {http://nlp.stanford.edu/IR-book/html/htmledition/text-classification-and-naive-bayes-1.html Text classification &amp; Naive Bayes}
      #
      # @example
      #   classifier = NLP::Classifiers::NaiveBayes::Multinomial.new
      #
      #   classifier.train(:china, %W{ Chinese Beijing Chinese })
      #   classifier.train(:china, %W{ Chinese Chinese Shanghai })
      #   classifier.train(:china, %W{ Chinese Macao })
      #   classifier.train(:japan, %W{ Tokyo Japan Chinese })
      #
      #   results = classifier.apply(%W{ Chinese Chinese Chinese Tokyo Japan })
      #
      #   results.first[:class] # => :china
      #   results.first[:score] # => -8.10769031284391
      #
      class Multinomial

        def initialize
          @class_counts = Hash.new(0)
          @vocabularies = Hash.new
          @vocabulary   = Hash.new
        end

        # Train the classifier with a document and class type
        #
        # @example
        #   classifier.train(:china, %W{ Chinese Beijing Chinese })
        #
        # @param [Object] klass An identifier for the class type
        # @param [Enumerable] document The document to train on
        # @return [Nil]
        def train(klass, document)
          @class_counts[klass] += 1
          document.each do |word|
            (@vocabularies[klass] ||= Hash.new(0))[word] += 1
            @vocabulary[word] = true
          end
        end

        # Apply the classifier to a new document
        #
        # @example
        #   classifier.apply(%W{ Chinese Chinese Chinese Tokyo Japan })
        #
        #   #=> [
        #        { :class => :china, :score => -8.1076 },
        #        { :class => :japan, :score => -8.9066 }
        #       ]
        #
        # @param [Enumerable] document The document to classify
        # @return [Array] An ordered array of results, the top one will have the highest score
        def apply(document)

          v = @vocabulary.keys.size
          d = @class_counts.values.reduce(:+).to_f

          results = @vocabularies.keys.map do |klass|
            prior = Math.log( @class_counts[klass] / d )
            c_den = ( @vocabularies[klass].values.reduce(:+) + v ).to_f
            score = document.reduce(prior) { |a, w| a += Math.log( ( @vocabularies[klass][w] + 1 ) / c_den ) }
            { :class => klass, :score => score }
          end

          results.sort do |a, b|
            b[:score] <=> a[:score]
          end

        end

      end

    end
  end
end