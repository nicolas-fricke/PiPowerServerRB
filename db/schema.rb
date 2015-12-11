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

ActiveRecord::Schema.define(version: 20151211170922) do

  create_table "frequencies", force: :cascade do |t|
    t.string   "system_code",                 null: false
    t.integer  "socket_code",                 null: false
    t.boolean  "is_on",       default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "power_outlet_groups", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.string   "permalink"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "power_outlets", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "location"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "frequency_id"
  end

  add_index "power_outlets", ["frequency_id"], name: "index_power_outlets_on_frequency_id"

end
