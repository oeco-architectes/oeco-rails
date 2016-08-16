require 'mozaic/mozaic'

class MozaicTest < ActiveSupport::TestCase

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
