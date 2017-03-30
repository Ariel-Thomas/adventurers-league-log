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

ActiveRecord::Schema.define(version: 20170330105802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adventures", force: :cascade do |t|
    t.string  "name",                        null: false
    t.boolean "active",       default: true, null: false
    t.integer "position_num"
  end

  create_table "campaign_participations", force: :cascade do |t|
    t.integer "campaign_id"
    t.integer "character_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string  "name"
    t.string  "token"
    t.boolean "users_can_join",   default: false, null: false
    t.boolean "publicly_visible", default: false, null: false
    t.string  "dm_token"
    t.boolean "dms_can_join",     default: false, null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string  "name"
    t.string  "race"
    t.string  "class_and_levels"
    t.string  "faction_override"
    t.integer "user_id"
    t.string  "portrait_url"
    t.boolean "publicly_visible",   default: false, null: false
    t.integer "faction_id"
    t.string  "background"
    t.integer "lifestyle_id"
    t.string  "lifestyle_override"
  end

  create_table "dm_campaign_assignments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "campaign_id"
  end

  create_table "faction_ranks", force: :cascade do |t|
    t.string  "name"
    t.integer "numerical_rank"
    t.integer "faction_id"
  end

  create_table "factions", force: :cascade do |t|
    t.string "name"
    t.string "flag_url"
  end

  create_table "lifestyles", force: :cascade do |t|
    t.string "name"
  end

  create_table "log_assignments", force: :cascade do |t|
    t.integer "character_id"
    t.integer "log_entry_id"
  end

  create_table "log_entries", force: :cascade do |t|
    t.datetime "date_played"
    t.string   "adventure_title"
    t.integer  "session_num"
    t.integer  "xp_gained"
    t.decimal  "gp_gained",            precision: 20, scale: 4
    t.integer  "renown_gained"
    t.integer  "downtime_gained"
    t.string   "location_played"
    t.string   "dm_name"
    t.string   "dm_dci_number"
    t.string   "notes",                                         default: "", null: false
    t.integer  "num_secret_missions"
    t.string   "type"
    t.integer  "player_dm_id"
    t.datetime "date_dmed"
    t.integer  "campaign_id"
    t.integer  "session_length_hours"
    t.integer  "player_level"
    t.integer  "user_id"
  end

  create_table "magic_items", force: :cascade do |t|
    t.string  "name"
    t.integer "log_entry_id"
    t.integer "rarity",             default: 0,  null: false
    t.string  "notes",              default: "", null: false
    t.integer "trade_log_entry_id"
    t.string  "table"
    t.string  "table_result"
    t.string  "location_found"
    t.integer "character_id"
  end

  create_table "player_dms", force: :cascade do |t|
    t.string  "name"
    t.string  "dci"
    t.integer "user_id"
  end

  create_table "schema_seeds", id: false, force: :cascade do |t|
    t.string "version", limit: 20, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                       default: "", null: false
    t.string   "encrypted_password",          default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "dci_num"
    t.boolean  "publicly_visible_dm_logs"
    t.boolean  "receive_emails"
    t.boolean  "publicly_visible_characters"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
