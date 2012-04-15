desc "Run specs"
task :spec do
  sh "rspec spec"
end

namespace :examples do

  namespace :classifiers do

    desc "Run examples/classifiers/naive_bayes.rb"
    task :naive_bayes do
      sh "ruby -I lib/ examples/classifiers/naive_bayes.rb"
    end

  end
end
