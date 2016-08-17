# frozen_string_literal: true
require_relative './tile'

module Mozaic
  # A utility class that helps displaying items in a rectangular grid. Dimensions
  # of each items can either be:
  # 1. small: 1x1
  # 2. large: 1x2
  # 3. tall: 2x1
  class Mozaic
    def initialize(rows, columns)
      @rows = rows
      @columns = columns
      @tiles = Array.new(rows) { Array.new(columns, Tile::EMPTY) }
    end

    def line_to_s(row, top, separator = '')
      @tiles[row].map { |tile| Tile.to_s(tile, top) }.join(separator)
    end

    def to_s
      [
        "╔═#{'═══' * @columns}═╗",
        (0..@rows - 1).map do |row|
          [true, false].map do |top|
            "║ #{line_to_s(row, top)} ║"
          end
        end,
        "╚═#{'═══' * @columns}═╝"
      ].flatten.join("\n")
    end

    def set(tile, row, column)
      raise ArgumentError, 'Column cannot be negative' if column.negative?
      raise ArgumentError, "Column cannot be greater or equal than #{@columns}" if column >= @columns
      raise ArgumentError, 'Row cannot be negative' if row.negative?
      raise ArgumentError, "Unknown tile type \"#{tile}\"" unless Tile.values.include?(tile)
      raise ArgumentError, "A tile already exists at row #{row}, column #{column}" if @tiles[row][column] != Tile::EMPTY

      @tiles[row][column] = tile
    end

    def empty!
      @rows.times do |row|
        @columns.times do |column|
          @tiles[row][column] = Tile::EMPTY
        end
      end
    end

    def to_s
      buffer = "#{self.class.h_border(@columns + 2, true)}\n"
      @rows.times do |row|
        buffer << "║ #{@tiles[row].map { |t| Tile.tile_to_s(t, true) }.join} ║\n"
        buffer << "║ #{@tiles[row].map { |t| Tile.tile_to_s(t, false) }.join} ║\n"
      end
      buffer << "#{self.class.h_border(@columns + 2, false)}"
      buffer
    end

    def get(row, column)
      @tiles[row][column]
    end

    def set(tile, row, column)
      raise ArgumentError, 'Column cannot be negative' if column.negative?
      raise ArgumentError, "Column cannot be greater or equal than #{@columns}" if column >= @columns
      raise ArgumentError, 'Row cannot be negative' if row.negative?
      raise ArgumentError, "Unknown tile type \"#{tile}\"" unless Tile.values.include?(tile)
      raise ArgumentError, "A tile already exists at row #{row}, column #{column}" if @tiles[row][column] != Tile::EMPTY

      @tiles[row][column] = tile
    end

    def assert_tiles(small_tiles, tall_tiles, wide_tiles)
      total_tiles = small_tiles + 2 * (tall_tiles + wide_tiles)
      if @rows * @columns != total_tiles
        raise ArgumentError, "Cannot fit #{total_tiles} tiles in a #{@rows}x#{@columns} mozaic"
      end
    end

    def set_randomly(small_tiles, tall_tiles, wide_tiles)
      tile, row, column = determine_tile(small_tiles, tall_tiles, wide_tiles)
      set(tile, row, column)
      case tile
      when Tile::TALL_TOP then set(Tile::TALL_BOTTOM, row + 1, column)
      when Tile::WIDE_LEFT then set(Tile::WIDE_RIGHT, row, column + 1)
      end

      tile
    end

    def fill!(small_tiles, tall_tiles, wide_tiles)
      assert_tiles(small_tiles, tall_tiles, wide_tiles)

      (small_tiles + tall_tiles + wide_tiles).times do
        tile = set_randomly(small_tiles, tall_tiles, wide_tiles)
        case tile
        when Tile::SMALL then small_tiles -= 1
        when Tile::TALL_TOP then tall_tiles -= 1
        when Tile::WIDE_LEFT then wide_tiles -= 1
        end
      end

      self
    end

    def determine_tile(small_tiles, tall_tiles, wide_tiles)
      sizes = [
        [Tile::SMALL, small_tiles, available_small_slots],
        [Tile::TALL_TOP, tall_tiles, available_tall_slots],
        [Tile::WIDE_LEFT, wide_tiles, available_wide_slots]
      ]
      sizes = sizes.map do |tile, remaining, available_slots|
        if remaining > available_slots.length
          raise ArgumentError,
                "Impossible to determine tile position for Tile::#{Tile.sym(tile)}, " \
                "only #{available_slots.length} slots available for #{remaining} tiles" \
                ":\n#{self}"
        end

        probability =
          if remaining.zero? then -1
          elsif tile == Tile::SMALL then 0 # Position small tiles at the end to reduce risk of locks
          else remaining.to_f / available_slots.length
          end

        [tile, remaining, available_slots, probability]
      end
      sizes = sizes.sort_by { |_, _, _, probability| -probability }

      tile, _, available_slots = sizes[0]
      row, column = available_slots.sample
      [tile, row, column]
    end

    def available_small_slots
      available_slots = []
      @rows.times do |i|
        @columns.times do |j|
          available_slots << [i, j] if @tiles[i][j] == Tile::EMPTY
        end
      end
      available_slots
    end

    def available_tall_slots
      available_slots = []
      (@rows - 1).times do |i|
        @columns.times do |j|
          if @tiles[i][j] == Tile::EMPTY && @tiles[i + 1][j] == Tile::EMPTY
            available_slots << [i, j]
          end
        end
      end
      available_slots
    end

    def available_wide_slots
      available_slots = []
      @rows.times do |i|
        (@columns - 1).times do |j|
          if @tiles[i][j] == Tile::EMPTY && @tiles[i][j + 1] == Tile::EMPTY
            available_slots << [i, j]
          end
        end
      end
      available_slots
    end

    def matching_tiles?
      valid = true
      @rows.times do |row|
        @columns.times do |column|
          valid = false unless
          case @tiles[row][column]
          when Tile::SMALL then true
          when Tile::TALL_TOP then row + 1 < @rows && @tiles[row + 1][column] == Tile::TALL_BOTTOM
          when Tile::TALL_BOTTOM then row - 1 >= 0 && @tiles[row - 1][column] == Tile::TALL_TOP
          when Tile::WIDE_LEFT then column + 1 < @columns && @tiles[row][column + 1] == Tile::WIDE_RIGHT
          when Tile::WIDE_RIGHT then column - 1 >= 0 && @tiles[row][column - 1] == Tile::WIDE_LEFT
          else false
          end
        end
      end
      valid
    end

    def filled?
      @tiles.all? do |row_tiles|
        row_tiles.all? { |tile| tile != Tile::EMPTY }
      end
    end

    def valid?
      filled? && matching_tiles?
    end

    def self.create(items, columns, options = {})
      if items < columns
        raise ArgumentError, "Cannot fill #{items} items in #{columns} columns"
      end
      if 2 * items < columns
        tall_frequency = 0
        wide_frequency = columns.to_f / (2.0 * items)
      else
        tall_frequency = items < 2 * columns ? 0 : options[:tall_frequency] || 1.0 / 3
        wide_frequency = columns < 2 ? 0 : options[:wide_frequency] || 1.0 / 3
      end
      small_frequency = 1.0 - tall_frequency - wide_frequency

      ideal_small_tiles = small_frequency * items
      ideal_tall_tiles = tall_frequency * items
      ideal_wide_tiles = wide_frequency * items

      tall_tiles = ideal_tall_tiles.round
      wide_tiles = ideal_wide_tiles.round
      small_tiles = items - wide_tiles - tall_tiles

      ideal_rows = (ideal_small_tiles + 2.0 * ideal_tall_tiles + 2.0 * ideal_wide_tiles) / columns
      rows = ideal_rows < 1.0 ? 1 : ideal_rows.floor
      rows += 1 if items > rows * columns

      while small_tiles + 2 * (wide_tiles + tall_tiles) < rows * columns
        small_tiles -= 1
        wide_tiles += 1
      end

      # Increments small tiles until we reach desired result
      while small_tiles + 2 * (wide_tiles + tall_tiles) != rows * columns
        small_tiles += 1
        if tall_tiles.positive? && (wide_tiles.zero? || tall_frequency - tall_tiles.to_f / items < wide_frequency - wide_tiles.to_f / items)
          tall_tiles -= 1
        elsif wide_tiles.positive?
          wide_tiles -= 1
        else
          raise 'Failed finding the appropriate number of tiles to fill a ' \
                "#{rows}x#{columns} mozaic. Stopped at #{small_tiles - 1} small, " \
                "#{tall_tiles} tall, and #{wide_tiles} wide tiles after swapping " \
                "tall and wide tiles by small ones #{ideal_rows}"
        end
      end

      mozaic = new(rows, columns)

      retries = options[:retries] || 10
      remaining_tries = retries
      loop do
        begin
          mozaic.fill!(small_tiles, tall_tiles, wide_tiles)
          break
        rescue
          if remaining_tries.zero?
            raise "Failed filling #{items} items in a #{rows}x#{columns} " \
                  "mozaic with #{small_tiles} small, #{tall_tiles} tall, and " \
                  "#{wide_tiles} wide tiles after #{retries} retries"
          end
          remaining_tries -= 1
          mozaic.empty!
        end
      end

      mozaic
    end
  end
end
