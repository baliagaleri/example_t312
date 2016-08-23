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

ActiveRecord::Schema.define(version: 20160823155028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "operation_states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_details", ["order_id"], name: "index_order_details_on_order_id", using: :btree
  add_index "order_details", ["product_id"], name: "index_order_details_on_product_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.date     "date_order"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "operation_state_id"
  end

  add_index "orders", ["operation_state_id"], name: "index_orders_on_operation_state_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "payment_type_codes", force: :cascade do |t|
    t.string   "initials"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "response_codes", force: :cascade do |t|
    t.integer  "value"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "rut"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vcis", force: :cascade do |t|
    t.string   "initials"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "vouchers", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "accounting_date"
    t.string   "buy_order"
    t.string   "cardnumber"
    t.string   "amount"
    t.string   "commerce_code"
    t.string   "authorization_code"
    t.string   "payment_type_code"
    t.string   "response_code"
    t.string   "transaction_date"
    t.string   "url_direction"
    t.string   "vci"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "vouchers", ["order_id"], name: "index_vouchers_on_order_id", using: :btree

  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "operation_states"
  add_foreign_key "orders", "users"
  add_foreign_key "vouchers", "orders"
end
