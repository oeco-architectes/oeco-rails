# frozen_string_literal: true
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_160_720_204_005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'news', force: :cascade do |t|
    t.string   'slug'
    t.string   'title'
    t.string   'summary'
    t.integer  'order'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order'], name: 'index_news_on_order', unique: true, using: :btree
    t.index ['slug'], name: 'index_news_on_slug', unique: true, using: :btree
  end

  create_table 'projects', force: :cascade do |t|
    t.string   'slug'
    t.string   'title'
    t.string   'summary'
    t.string   'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['slug'], name: 'index_projects_on_slug', unique: true, using: :btree
  end
end
