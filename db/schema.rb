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

ActiveRecord::Schema.define(version: 2021_04_13_225351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "back_ops_actions", force: :cascade do |t|
    t.bigint "operation_id"
    t.integer "order", default: 0, null: false
    t.text "name"
    t.text "error_message"
    t.text "stack_trace"
    t.datetime "errored_at"
    t.datetime "completed_at"
    t.integer "attempts_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["operation_id"], name: "index_back_ops_actions_on_operation_id"
  end

  create_table "back_ops_operations", force: :cascade do |t|
    t.string "name"
    t.string "params_hash"
    t.jsonb "context", default: {}, null: false
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "params_hash"], name: "index_back_ops_operations_on_name_and_params_hash"
  end

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "messages_count", default: 0, null: false
    t.bigint "users_count", default: 0, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "channel_user_id"
    t.text "body"
    t.text "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "channel_id"
    t.bigint "user_id"
    t.index ["channel_user_id"], name: "index_messages_on_channel_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "auth_token", limit: 32
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["auth_token"], name: "index_users_on_auth_token"
  end

end
