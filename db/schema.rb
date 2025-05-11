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

ActiveRecord::Schema[8.0].define(version: 2025_05_10_190722) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "boards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.text "banner"
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "columns", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "position", default: 0, null: false
    t.boolean "is_done_column", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id", "position"], name: "index_columns_on_board_id_and_position"
    t.index ["board_id"], name: "index_columns_on_board_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "title", null: false
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "labels_tasks", id: false, force: :cascade do |t|
    t.bigint "label_id", null: false
    t.bigint "task_id", null: false
    t.index ["label_id", "task_id"], name: "index_labels_tasks_on_label_id_and_task_id", unique: true
    t.index ["task_id", "label_id"], name: "index_labels_tasks_on_task_id_and_label_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "column_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "difficulty", default: 1, null: false
    t.datetime "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_id"], name: "index_tasks_on_column_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.text "profile_photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "boards", "users"
  add_foreign_key "columns", "boards"
  add_foreign_key "tasks", "columns"
end
