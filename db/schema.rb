# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_01_065416) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "plays", force: :cascade do |t|
    t.string "action"
    t.integer "chips"
    t.bigint "user_id", null: false
    t.bigint "round_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_plays_on_round_id"
    t.index ["user_id"], name: "index_plays_on_user_id"
  end

  create_table "prizes", force: :cascade do |t|
    t.integer "place"
    t.integer "prize_cents"
    t.bigint "tournament_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_prizes_on_tournament_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "flop"
    t.string "turn"
    t.string "river"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "table_rounds", force: :cascade do |t|
    t.bigint "table_id", null: false
    t.bigint "round_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_table_rounds_on_round_id"
    t.index ["table_id"], name: "index_table_rounds_on_table_id"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "number_of_seats"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournament_players", force: :cascade do |t|
    t.integer "finished_at"
    t.bigint "user_id", null: false
    t.bigint "tournament_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_tournament_players_on_tournament_id"
    t.index ["user_id"], name: "index_tournament_players_on_user_id"
  end

  create_table "tournament_tables", force: :cascade do |t|
    t.bigint "tournament_id", null: false
    t.bigint "table_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_id"], name: "index_tournament_tables_on_table_id"
    t.index ["tournament_id"], name: "index_tournament_tables_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "number"
    t.integer "buy_in_cents"
    t.integer "number_of_seats"
    t.integer "tax_cents"
    t.datetime "started_at"
    t.integer "initial_chips"
    t.integer "total_prize_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_hands", force: :cascade do |t|
    t.string "first_pocket_card"
    t.string "second_pocket_card"
    t.bigint "round_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_user_hands_on_round_id"
    t.index ["user_id"], name: "index_user_hands_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "plays", "rounds"
  add_foreign_key "plays", "users"
  add_foreign_key "prizes", "tournaments"
  add_foreign_key "table_rounds", "rounds"
  add_foreign_key "table_rounds", "tables"
  add_foreign_key "tournament_players", "tournaments"
  add_foreign_key "tournament_players", "users"
  add_foreign_key "tournament_tables", "tables"
  add_foreign_key "tournament_tables", "tournaments"
  add_foreign_key "user_hands", "rounds"
  add_foreign_key "user_hands", "users"
end
