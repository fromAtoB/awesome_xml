# frozen_string_literal: true

# A representation of a user defined duration format.
module AwesomeXML
  class Duration
    class Format
      attr_reader :format_string, :chunks
      private :format_string

      # Returns an `AwesomeXML::Duration::Format` instance representing a user defined
      # duration format specified by the passed in `format_string`. Splits the format
      # string into chunks that are each one of either `AwesomeXML::Duration::Format::StaticChunk`
      # or `AwesomeXML::Duration::Format::DynamicChunk` and saves them in the attribute `chunks`.
      # The latter class mentioned is used for a section of the format string inside curly
      # brackets. For more information about the syntax of the format string, read the README.
      def initialize(format_string)
        @format_string = format_string
        @chunks = []
        compile
      end

    private

      def compile
        format_string.chars.each(&method(:process))
        @chunks = chunks&.compact
      end

      def process(character)
        case character
        when '{'
          chunks.append(DynamicChunk.new)
        when '}'
          chunks.append(nil)
        else
          if chunks.last.nil? 
            if chunks[-2].is_a?(DynamicChunk)
              chunks[-2].delimiter = character
            end
            chunks.tap(&:pop).append(StaticChunk.new)
          end

          chunks.last.format_chars.append(character)
        end
      end
    end
  end
end
