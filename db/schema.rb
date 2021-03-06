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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130710193732) do

  create_table "accounts", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "achievements", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "notes"
    t.integer  "website_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "awards", :force => true do |t|
    t.string   "to"
    t.integer  "achievement_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "records", :force => true do |t|
    t.string   "user"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "tracker_id"
    t.integer  "counter"
  end

  create_table "trackers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "website_id"
  end

  create_table "triggers", :force => true do |t|
    t.integer  "tracker_id"
    t.integer  "threshold"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "action"
    t.integer  "object"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "websites", :force => true do |t|
    t.string   "name"
    t.string   "domain"
    t.integer  "owner"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
