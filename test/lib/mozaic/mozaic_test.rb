# frozen_string_literal: true
require 'mozaic/mozaic'

# Test for Mozaic
class MozaicTest < ActiveSupport::TestCase
  test '#to_s displays the mozaic' do
    mozaic = Mozaic::Mozaic.new(2, 3)
    mozaic.set(Mozaic::Tile::SMALL, 0, 0)
    mozaic.set(Mozaic::Tile::EMPTY, 0, 1)
    mozaic.set(Mozaic::Tile::WIDE_LEFT, 1, 0)
    mozaic.set(Mozaic::Tile::WIDE_RIGHT, 1, 1)
    mozaic.set(Mozaic::Tile::TALL_TOP, 0, 2)
    mozaic.set(Mozaic::Tile::TALL_BOTTOM, 1, 2)
    assert_equal mozaic.to_s, [
      '╔═══════════╗',
      '║ ┌─┐   ┌─┐ ║',
      '║ └─┘   │ │ ║',
      '║ ┌────┐│ │ ║',
      '║ └────┘└─┘ ║',
      '╚═══════════╝'
    ].join("\n")
  end

  test '.creates throws an error when items > columns' do
    assert_raises { Mozaic::Mozaic.create(101, 100) }
  end

  test '.creates fills only with small tiles when items == columns' do
    mozaic = Mozaic::Mozaic.create(100, 100)
    100.times do |i|
      assert_equal mozaic.get(0, i), Mozaic::Tile::SMALL
    end
  end

  MAX_COLUMNS = 10
  MAX_ITEMS = 40
  TIMES = 100

  (1..MAX_COLUMNS).each do |columns|
    (1..MAX_ITEMS).each do |items|
      next if items < columns

      test ".creates creates #{TIMES} times a mozaic with #{columns} columns " \
           "for #{items} items" do
        (1..TIMES).each do
          mozaic = Mozaic::Mozaic.create(items, columns)
          assert mozaic.valid?
        end
      end
    end
  end
end
