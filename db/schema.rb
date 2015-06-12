# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150611065443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stock_heat_ranks", force: :cascade do |t|
    t.integer  "stock_id"
    t.integer  "heat",       default: 0
    t.date     "date"
    t.integer  "post_count", default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "stock_heat_ranks", ["heat"], name: "index_stock_heat_ranks_on_heat", using: :btree
  add_index "stock_heat_ranks", ["stock_id", "date"], name: "index_stock_heat_ranks_on_stock_id_and_date", unique: true, using: :btree

  create_table "stocks", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stocks", ["code"], name: "index_stocks_on_code", unique: true, using: :btree
  add_index "stocks", ["name"], name: "index_stocks_on_name", unique: true, using: :btree

end
