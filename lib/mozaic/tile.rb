# frozen_string_literal: true
module Mozaic
  # Tile types
  class Tile
    EMPTY = 0
    SMALL = 1
    TALL_TOP = 2
    TALL_BOTTOM = 3
    WIDE_LEFT = 4
    WIDE_RIGHT = 5

    def self.to_s(value, top)
      [
        ['   ', '┌─┐', '┌─┐', '│ │', '┌──', '──┐'],
        ['   ', '└─┘', '│ │', '└─┘', '└──', '──┘']
      ][top ? 0 : 1][value]
    end

    def self.values
      constants.map { |sym| const_get(sym) }
    end

    def self.symbols
      constants.map.with_index { |symbol, value| [value, symbol] }.to_h
    end

    def self.sym(value)
      symbols[value]
    end
  end
end
