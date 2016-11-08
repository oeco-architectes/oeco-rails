# frozen_string_literal: true

# Create news table
class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :slug
      t.string :title
      t.string :summary
      t.integer :order
      t.timestamps null: false
    end

    add_index :news, :slug, unique: true
    add_index :news, :order, unique: true
  end
end
