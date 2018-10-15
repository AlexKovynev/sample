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

ActiveRecord::Schema.define(version: 2018_10_12_034238) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exchanges", force: :cascade do |t|
    t.string "title"
    t.string "uid"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_exchanges_on_title", unique: true
    t.index ["uid"], name: "index_exchanges_on_uid"
  end

  create_table "markets", force: :cascade do |t|
    t.string "uid"
    t.jsonb "data"
    t.bigint "exchange_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exchange_id"], name: "index_markets_on_exchange_id"
    t.index ["uid", "exchange_id"], name: "index_markets_on_uid_and_exchange_id", unique: true
  end

  add_foreign_key "markets", "exchanges"
end
