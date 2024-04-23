# frozen_string_literal: true

require_relative '../table'

module TTFunk
  class Table
    # Maximum Profile (`maxp`) table
    class Maxp < Table
      # Default maximum levels of recursion.
      DEFAULT_MAX_COMPONENT_DEPTH = 1

      # Size of full table version 1.
      MAX_V1_TABLE_LENGTH = 32

      # Table version.
      # @return [Integer]
      attr_reader :version

      # The number of glyphs in the font.
      # @return [Integer]
      attr_reader :num_glyphs

      # Maximum points in a non-composite glyph.
      # @return [Integer]
      attr_reader :max_points

      # Maximum contours in a non-composite glyph.
      # @return [Integer]
      attr_reader :max_contours

      # Maximum points in a composite glyph.
      # @return [Integer]
      attr_reader :max_component_points

      # Maximum contours in a composite glyph.
      # @return [Integer]
      attr_reader :max_component_contours

      # Maximum zones.
      # * 1 if instructions do not use the twilight zone (Z0)
      # * 2 if instructions do use Z0
      # @return [Integer]
      attr_reader :max_zones

      # Maximum points used in Z0.
      # @return [Integer]
      attr_reader :max_twilight_points

      # Number of Storage Area locations.
      # @return [Integer]
      attr_reader :max_storage

      # Number of FDEFs.
      # @return [Integer]
      attr_reader :max_function_defs

      # Number of IDEFs.
      # @return [Integer]
      attr_reader :max_instruction_defs

      # Maximum stack depth across Font Program, CVT Program and all glyph
      # instructions.
      # @return [Integer]
      attr_reader :max_stack_elements

      # Maximum byte count for glyph instructions.
      # @return [Integer]
      attr_reader :max_size_of_instructions

      # Maximum number of components referenced at "top level" for any composite
      # glyph.
      # @return [Integer]
      attr_reader :max_component_elements

      # Maximum levels of recursion.
      # @return [Integer]
      attr_reader :max_component_depth

      # Encode table.
      #
      # @param maxp [TTFunk::Table::Maxp]
      # @param mapping [Hash{Integer => Integer}] keys are new glyph IDs, values
      #   are old glyph IDs.
      # @return [String]
      def self.encode(maxp, mapping)
        num_glyphs = mapping.length
        raw = maxp.raw
        raw[4, 2] = [num_glyphs].pack('n')
        raw
      end

      private

      def parse!
        @version, @num_glyphs, @max_points, @max_contours,
          @max_component_points, @max_component_contours, @max_zones,
          @max_twilight_points, @max_storage, @max_function_defs,
          @max_instruction_defs, @max_stack_elements, @max_size_of_instructions,
          @max_component_elements, @max_component_depth = read(length, 'Nn*')
      end
    end
  end
end
