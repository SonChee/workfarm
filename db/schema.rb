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

ActiveRecord::Schema.define(version: 20140321121621) do

  create_table "users", force: true do |t|
    t.string   "code"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "birthday"
    t.integer  "city_id"
    t.integer  "home_town_id"
    t.string   "address"
    t.integer  "university_id"
    t.integer  "class_id"
    t.integer  "permit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["code"], name: "index_users_on_code", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
