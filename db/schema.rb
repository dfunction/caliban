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

ActiveRecord::Schema.define(version: 20140228023247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contactpings", force: true do |t|
    t.integer  "contact_id"
    t.integer  "ping_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

  create_table "pings", force: true do |t|
    t.string   "frequency"
    t.string   "type"
    t.datetime "lastRun"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pings", ["user_id"], name: "index_pings_on_user_id", using: :btree

  create_table "pointers", force: true do |t|
    t.string   "type"
    t.string   "value"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pointers", ["contact_id"], name: "index_pointers_on_contact_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "eid"
    t.string   "name"
    t.string   "phoneNumber"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
