require 'mozaic/mozaic'

class MozaicTest < ActiveSupport::TestCase

  test 'to_s displays the mozaic' do
    mozaic = Mozaic.new(2, 3)
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

  CI = ENV.key?('CI')
  MAX_COLUMNS = CI ? 10 : 4
  MAX_ITEMS = CI ? 40 : 20
  ITEMS = CI ? 50 : 10

  (1..MAX_COLUMNS).each do |columns|
    (1..MAX_ITEMS).each do |items|
      next if items < columns

      test "can create a mozaic with #{columns} columns for #{items} items" do
        (1..ITEMS).each do
          mozaic = Mozaic.create(items, columns)
          assert mozaic.valid?
        end
      end
    end
  end
end
