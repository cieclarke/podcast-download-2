# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_10_101730) do

  create_table "episodes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "guid"
    t.string "title"
    t.string "genre"
    t.date "publication_date"
    t.string "url"
    t.string "artist"
    t.string "album"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "podcast_id"
    t.index ["podcast_id"], name: "index_episodes_on_podcast_id"
  end

  create_table "podcasts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "url"
    t.string "artist"
    t.string "album"
    t.integer "recent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "episode_id"
    t.index ["episode_id"], name: "index_podcasts_on_episode_id"
  end

end
