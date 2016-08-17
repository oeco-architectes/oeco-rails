# frozen_string_literal: true
class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :slug
      t.string :title
      t.string :summary
      t.string :content
      t.boolean published: false
      t.timestamps null: false
    end

    add_index :projects, :slug, unique: true
  end
end
