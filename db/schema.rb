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

ActiveRecord::Schema.define(version: 2019_05_28_052607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "ratings"
    t.index ["name", "user_id"], name: "index_foods_on_name_and_user_id", unique: true
    t.index ["user_id"], name: "index_foods_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "food_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 0
    t.index ["food_id"], name: "index_order_items_on_food_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "transaction_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.hstore "billing_address"
    t.integer "stripe_customer_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payment_methods_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "weekday"
    t.integer "quantity"
    t.bigint "food_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id", "quantity", "weekday"], name: "index_schedules_on_food_id_and_quantity_and_weekday", unique: true
    t.index ["food_id"], name: "index_schedules_on_food_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.hstore "address"
    t.string "phone_number"
    t.boolean "verified", default: false
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "about"
    t.float "latitude"
    t.float "longitude"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "foods", "users"
  add_foreign_key "order_items", "foods"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "payment_methods", "users"
  add_foreign_key "schedules", "foods"
end
