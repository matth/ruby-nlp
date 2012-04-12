require 'stringio'

module NLP
  class Tokenizer

    include Enumerable

    attr_reader :stream, :delimiter

    def initialize(stream)
      @stream = stream.class == String ? StringIO.new(stream) : stream
    end

    def each

      stream.rewind

      stream.each_line do |line|
        line.squeeze(" ").split(" ").each { |s| yield s }
      end

    end

  end
end