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

ActiveRecord::Schema.define(version: 20161031070524) do

  create_table "multilingual_languages", force: :cascade do |t|
    t.string "code", limit: 2
    t.index ["code"], name: "index_multilingual_languages_on_code", unique: true
  end

  create_table "multilingual_translations", force: :cascade do |t|
    t.string  "content"
    t.integer "language_id"
    t.string  "translatable_type"
    t.integer "translatable_id"
    t.index ["translatable_type", "translatable_id"], name: "index_multilingual_translations_translatable"
  end

end
