require 'pp'

module NLP
  module Stemmers
    module Levenshtein

      def self.distance(i, j)
        n = i.size
        m = j.size
        d = Array.new(n + 1) { Array.new(m + 1) }

        (n + 1).times { |x| d[x][0] = x }
        (m + 1).times { |x| d[0][x] = x }

        (1..n).each do |y|
          (1..m).each do |x|

            if (i[y-1] != j[x-1])
              substitution = 2
            else
              substitution = 0
            end

            d[y][x] = [
              d[y-1][x]   + 1,
              d[y][x-1]   + 1,
              d[y-1][x-1] + substitution
            ].min

          end
        end

        d[n][m]

      end

    end
  end
end