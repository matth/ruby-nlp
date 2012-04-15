require 'nlp'

# This is an example of using the Bayes classifier to do sentiment analysis on IMDB film reviews.
#
# The data provided is that used in the paper Bo Pang, Lillian Lee, and
# Shivakumar Vaithyanathan. 2002. Thumbs up? Sentiment Classification using Machine Learning Techniques.
# Proceedings of the Conference on Empirical Methods in Natural Language Processing (EMNLP), pp. 79-86.
#
# Data is found in corpora/imdb
#
# The program splits the data into 10 folds, each containing a 90/10 split of training/test data. The
# classifier used is the Multinomial model.
#
# This program also highlights how slow the code is, especially if you switch the classifier to be
# the Bernoulli model
#
# To run the example do either
#
#   ruby -I lib/ examples/classifiers/naive_bayes.rb
#
# Or
#
#   rake examples:classifiers:bayes
#
DATA_DIR = File.join( File.dirname(__FILE__), "..", "..", "corpora", "imdb", "*", "*.txt")

average_accuracy = 0.0

puts  "Performing 10-fold cross-validation on data set: imdb"

(1..10).each do |fold|

  classifier = NLP::Classifiers::NaiveBayes::Multinomial.new

  testing, training = Dir.glob(DATA_DIR).partition do |file|
    base = File.basename(file)
    num  = base[2..4].to_i
    num >= fold * 100 - 100 && num < fold * 100
  end

  training.each do |filename|
    klass  = File.basename File.dirname(filename)
    tokens = File.read(filename).split(" ")
    classifier.train(klass, tokens)
  end

  accuracy = 0

  testing.each do |filename|
    klass  = File.basename File.dirname(filename)
    tokens = File.read(filename).split(" ")
    result = classifier.apply(tokens).first[:class]
    if result == klass
      accuracy += 1
    end
  end

  accuracy = accuracy / testing.size.to_f
  average_accuracy += accuracy

  puts "Fold #{"%02d" % fold}: Accuracy #{ "%6f" % accuracy }"

end

puts "Accuracy: #{ "%6f" % (average_accuracy / 10) }"
