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

ActiveRecord::Schema.define(version: 20161005081823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "participants", force: :cascade do |t|
    t.integer "payer_id"
    t.integer "payment_id"
    t.float   "amount",     default: 0.0, null: false
    t.index ["payer_id"], name: "index_participants_on_payer_id", using: :btree
    t.index ["payment_id"], name: "index_participants_on_payment_id", using: :btree
  end

  create_table "payers", force: :cascade do |t|
    t.string  "name"
    t.integer "role"
    t.string  "email"
  end

  create_table "payments", force: :cascade do |t|
    t.string   "name"
    t.float    "amount"
    t.date     "date_of_payment"
    t.integer  "payer_id"
    t.string   "payment_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["payer_id"], name: "index_payments_on_payer_id", using: :btree
  end

end
