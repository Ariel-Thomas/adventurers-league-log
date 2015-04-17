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

ActiveRecord::Schema.define(version: 20150417091621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string  "name"
    t.string  "race"
    t.string  "class_and_levels"
    t.string  "faction"
    t.integer "user_id"
    t.string  "portrait_url"
    t.boolean "publicly_visible", default: false, null: false
    t.string  "faction_rank"
  end

  create_table "log_entries", force: :cascade do |t|
    t.integer "character_id"
    t.date    "date_played"
    t.string  "adventure_title"
    t.integer "session_num"
    t.integer "xp_gained"
    t.decimal "gp_gained",               precision: 20, scale: 4
    t.integer "num_magic_items_gained"
    t.string  "desc_magic_items_gained"
    t.integer "renown_gained"
    t.integer "downtime_gained"
    t.string  "location_played"
    t.string  "dm_name"
    t.string  "dm_dci_number"
    t.string  "notes",                                            default: "", null: false
    t.integer "num_secret_missions"
    t.string  "type"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "dci_num"
    t.boolean  "publicly_visible"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
