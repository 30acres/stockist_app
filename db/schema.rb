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

ActiveRecord::Schema.define(version: 20150206045738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "email_address"
    t.integer  "status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "seo_title"
    t.string   "seo_desc"
    t.integer  "status"
    t.text     "content"
    t.integer  "content_type"
    t.integer  "position"
    t.string   "slug"
    t.string   "parentals"
    t.string   "ancestry"
    t.string   "image"
    t.string   "template"
    t.integer  "client_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "retailers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "retailers", ["email"], name: "index_retailers_on_email", unique: true, using: :btree
  add_index "retailers", ["reset_password_token"], name: "index_retailers_on_reset_password_token", unique: true, using: :btree

  create_table "scrapes", force: :cascade do |t|
    t.string   "from_url"
    t.string   "from_id"
    t.string   "client_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stockists", force: :cascade do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "website"
    t.string   "postcode"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "primary_phone"
    t.string   "secondary_phone"
    t.string   "fax"
    t.text     "description"
    t.string   "photo_file"
    t.text     "operating_hours"
    t.string   "email_address"
    t.integer  "status"
    t.integer  "position"
    t.integer  "client_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "country_id"
    t.string   "slug"
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "title"
    t.string   "file"
    t.integer  "position"
    t.integer  "status"
    t.string   "source_url"
    t.integer  "upload_type"
    t.integer  "client_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
