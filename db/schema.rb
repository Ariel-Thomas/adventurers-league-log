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

ActiveRecord::Schema.define(version: 2020_09_20_003315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adventures", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.integer "position_num"
    t.integer "hours"
  end

  create_table "campaign_participations", id: :serial, force: :cascade do |t|
    t.integer "campaign_id"
    t.integer "character_id"
  end

  create_table "campaigns", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.boolean "users_can_join", default: false, null: false
    t.boolean "publicly_visible", default: false, null: false
    t.string "dm_token"
    t.boolean "dms_can_join", default: false, null: false
    t.integer "campaign_style", default: 1
    t.integer "campaign_log_entry_style", default: 1
  end

  create_table "characters", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "race"
    t.string "class_and_levels"
    t.string "faction_override"
    t.integer "user_id"
    t.string "portrait_url"
    t.boolean "publicly_visible", default: false, null: false
    t.integer "faction_id"
    t.string "background"
    t.integer "lifestyle_id"
    t.string "lifestyle_override"
    t.string "character_sheet_url"
    t.integer "conversion_type", default: 0
    t.integer "conversion_speed", default: 0
    t.integer "round_checkpoints", default: 0
    t.integer "automagic_gold_toggle", default: 0
    t.integer "automagic_downtime_toggle", default: 0
    t.string "season", default: ""
    t.string "tag", default: ""
    t.integer "indexed_level", default: 1
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "dm_campaign_assignments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "campaign_id"
  end

  create_table "faction_ranks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "numerical_rank"
    t.integer "faction_id"
  end

  create_table "factions", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "flag_url"
  end

  create_table "lifestyles", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
  end

  create_table "log_assignments", id: :serial, force: :cascade do |t|
    t.integer "character_id"
    t.integer "log_entry_id"
    t.index ["character_id", "log_entry_id"], name: "index_log_assignments_on_character_id_and_log_entry_id", unique: true
    t.index ["log_entry_id", "character_id"], name: "index_log_assignments_on_log_entry_id_and_character_id", unique: true
  end

  create_table "log_entries", id: :serial, force: :cascade do |t|
    t.datetime "date_played"
    t.string "adventure_title"
    t.integer "session_num"
    t.integer "xp_gained"
    t.decimal "gp_gained", precision: 20, scale: 4
    t.decimal "renown_gained", precision: 10, scale: 4
    t.decimal "downtime_gained", precision: 10, scale: 4
    t.string "location_played"
    t.string "dm_name"
    t.string "dm_dci_number"
    t.string "notes", default: "", null: false
    t.integer "num_secret_missions"
    t.string "type"
    t.integer "user_id"
    t.integer "player_dm_id"
    t.datetime "date_dmed"
    t.integer "campaign_id"
    t.integer "session_length_hours"
    t.integer "player_level"
    t.decimal "advancement_checkpoints", precision: 6, scale: 1
    t.decimal "treasure_checkpoints", precision: 6, scale: 1
    t.integer "treasure_tier"
    t.boolean "old_format", default: false, null: false
    t.decimal "tier1_treasure_checkpoints", precision: 6, scale: 1
    t.decimal "tier2_treasure_checkpoints", precision: 6, scale: 1
    t.decimal "tier3_treasure_checkpoints", precision: 6, scale: 1
    t.decimal "tier4_treasure_checkpoints", precision: 6, scale: 1
    t.integer "milestones_gained"
    t.integer "log_format", default: 0
    t.integer "dm_reward_choice", default: 0
    t.index ["campaign_id"], name: "index_log_entries_on_campaign_id"
    t.index ["user_id"], name: "index_log_entries_on_user_id"
  end

  create_table "magic_items", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "log_entry_id"
    t.integer "rarity", default: 0, null: false
    t.string "notes", default: "", null: false
    t.integer "trade_log_entry_id"
    t.string "table"
    t.string "table_result"
    t.string "location_found"
    t.integer "character_id"
    t.boolean "not_included_in_count", default: false, null: false
    t.integer "tier"
    t.boolean "purchased", default: false, null: false
    t.integer "purchase_log_entry_id"
    t.index ["log_entry_id", "character_id"], name: "index_magic_items_on_log_entry_id_and_character_id"
  end

  create_table "player_dms", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "dci"
    t.integer "user_id"
  end

  create_table "schema_seeds", id: false, force: :cascade do |t|
    t.string "version", limit: 20, null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.string "dci_num"
    t.boolean "publicly_visible_dm_logs"
    t.boolean "receive_emails"
    t.boolean "publicly_visible_characters"
    t.boolean "autocalc_default", default: true, null: false
    t.integer "character_style", default: 2
    t.integer "character_log_entry_style", default: 1
    t.integer "magic_item_style", default: 2
    t.integer "dm_style", default: 2
    t.integer "dm_log_entry_style", default: 1
    t.integer "round_checkpoints_override", default: 0
    t.integer "automagic_gold_toggle_override", default: 0
    t.integer "automagic_downtime_toggle_override", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
