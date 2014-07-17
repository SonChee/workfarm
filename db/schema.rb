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

ActiveRecord::Schema.define(version: 20140717012946) do

  create_table "chat_groups", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "note"
    t.integer  "farm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chat_messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "chat_group_id"
    t.string   "message"
    t.string   "to_user_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "farms", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.string   "parent_farm_id"
    t.integer  "kind"
    t.integer  "floor"
    t.integer  "big_farm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flag_reads", force: true do |t|
    t.integer  "user_id"
    t.integer  "chat_message_id"
    t.integer  "chat_group_id"
    t.integer  "flag",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "position_in_farms", force: true do |t|
    t.integer  "user_id"
    t.integer  "farm_id"
    t.integer  "position"
    t.integer  "farm_request", default: 0, null: false
    t.integer  "big_farm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.string   "kind"
    t.string   "short_description"
    t.string   "description"
    t.integer  "taskmaster_id"
    t.integer  "assignee_id"
    t.string   "status"
    t.integer  "process"
    t.datetime "start_date"
    t.datetime "due_date"
    t.float    "spent_time"
    t.float    "estimated_time"
    t.integer  "farm_id"
    t.integer  "project_id"
    t.integer  "target_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "type"
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
    t.integer  "current_big_farm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["code"], name: "index_users_on_code", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
