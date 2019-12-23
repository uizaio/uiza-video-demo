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

ActiveRecord::Schema.define(version: 2019_12_19_015058) do

  create_table "lives", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code", limit: 100, default: ""
    t.string "name", default: ""
    t.text "des"
    t.string "stream_url", default: ""
    t.string "stream_key", default: ""
    t.string "uiza_id", limit: 100, default: ""
    t.string "thumbnail", default: ""
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_lives_on_code"
    t.index ["uiza_id"], name: "index_lives_on_uiza_id"
  end

  create_table "videos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: ""
    t.string "code", limit: 100, default: ""
    t.string "view_url", default: ""
    t.string "uiza_id", limit: 100, default: ""
    t.string "thumbnail", default: ""
    t.text "embbed"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_videos_on_code"
    t.index ["uiza_id"], name: "index_videos_on_uiza_id"
  end

end
