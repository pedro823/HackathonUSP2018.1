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

ActiveRecord::Schema.define(version: 20180610032111) do

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tag"
    t.string "address"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
  end

  create_table "log_study_rooms", force: :cascade do |t|
    t.integer "study_room_id"
    t.boolean "taken"
    t.integer "time_of_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "study_rooms", force: :cascade do |t|
    t.string "name"
    t.integer "institution_id"
    t.integer "fits_number"
    t.boolean "is_free"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
