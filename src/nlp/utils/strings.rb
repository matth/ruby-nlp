module NLP
  module Utils
    module Strings

      # Calculate min edit distance betweeen two strings
      def min_edit_distance(string1, string2)

        return string1.size if string2.empty?
        return string2.size if string1.empty?

        i = string1.size
        j = string2.size
        d = Array.new(i + 1) { Array.new(j + 1) }

        (i + 1).times { |x| d[x][0] = x }
        (j + 1).times { |x| d[0][x] = x }

        (1..i).each do |row|
          (1..j).each do |column|

            if string1[row - 1] == string2[column - 1]
              d[row][column] = d[row - 1][column - 1]
            else
              d[row][column] = [
                d[row - 1][column]     + 1, # Deletion
                d[row][column - 1]     + 1, # Insertion
                d[row - 1][column - 1] + 1  # Substitution
              ].min
            end

          end
        end

        d[i][j]

      end

    end
  end
end