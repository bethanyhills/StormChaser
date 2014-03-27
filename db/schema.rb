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

ActiveRecord::Schema.define(version: 20140327205925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tornado_dates", force: true do |t|
    t.integer  "day"
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tornados", force: true do |t|
    t.integer  "tornado_dates_id"
    t.integer  "f_scale"
    t.integer  "hour"
    t.integer  "minute"
    t.integer  "time_zone"
    t.string   "state"
    t.integer  "injuries"
    t.integer  "fatalities"
    t.float    "property_loss"
    t.float    "crop_loss"
    t.float    "start_lat"
    t.float    "start_long"
    t.float    "stop_lat"
    t.float    "stop_long"
    t.float    "distance"
    t.float    "width"
    t.integer  "states_crossed"
    t.boolean  "complete_track"
    t.integer  "segment_num"
    t.integer  "county_code_one"
    t.integer  "county_code_two"
    t.integer  "county_code_three"
    t.integer  "county_code_four"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tornados", ["tornado_dates_id"], name: "index_tornados_on_tornado_dates_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
