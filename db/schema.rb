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

ActiveRecord::Schema.define(version: 20140807013213) do

  create_table "events", force: true do |t|
    t.integer  "venue_id"
    t.integer  "show_id"
    t.string   "status",     default: "active"
    t.datetime "time"
    t.text     "details"
    t.string   "url"
    t.string   "ticket_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["show_id"], name: "index_events_on_show_id"
  add_index "events", ["venue_id"], name: "index_events_on_venue_id"

  create_table "shows", force: true do |t|
    t.string   "imdb_id"
    t.string   "tmdb_id"
    t.string   "rt_id"
    t.string   "title"
    t.string   "rating",         limit: 20
    t.date     "release_date"
    t.integer  "runtime"
    t.text     "summary"
    t.text     "tagline"
    t.string   "poster_url"
    t.string   "backdrop_url"
    t.integer  "tomato_score"
    t.integer  "audience_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", force: true do |t|
    t.string   "place_id"
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.string   "address"
    t.string   "city"
    t.string   "state",       limit: 2
    t.string   "zipcode"
    t.string   "places_url"
    t.string   "url"
    t.string   "scraper_ref"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
