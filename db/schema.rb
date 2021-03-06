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

ActiveRecord::Schema.define(version: 2021_01_09_191853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.bigint "planet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "birth_year"
    t.string "mass"
    t.string "ext_id"
    t.index ["planet_id"], name: "index_people_on_planet_id"
  end

  create_table "people_species", id: false, force: :cascade do |t|
    t.bigint "species_id"
    t.bigint "person_id"
    t.index ["person_id"], name: "index_people_species_on_person_id"
    t.index ["species_id"], name: "index_people_species_on_species_id"
  end

  create_table "people_starcrafts", id: false, force: :cascade do |t|
    t.bigint "starcraft_id"
    t.bigint "person_id"
    t.index ["person_id"], name: "index_people_starcrafts_on_person_id"
    t.index ["starcraft_id"], name: "index_people_starcrafts_on_starcraft_id"
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "species", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "starcrafts", force: :cascade do |t|
    t.string "name"
    t.string "model"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
