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

ActiveRecord::Schema.define(version: 20161112001733) do

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
    t.string   "dropbox_session"
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

  create_table "downloads", force: :cascade do |t|
    t.string   "title"
    t.integer  "position"
    t.integer  "status"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enquiries", force: :cascade do |t|
    t.string   "username"
    t.string   "business_name"
    t.string   "contact_phone"
    t.string   "email"
    t.string   "website"
    t.string   "abn"
    t.string   "comments"
    t.string   "tried_products"
    t.string   "url"
    t.string   "src"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
    t.string   "localities"
    t.text     "business_profile"
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

  create_table "galleries", force: :cascade do |t|
    t.integer  "listing_id"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "file"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "listing_id"
    t.integer  "photo_id"
    t.string   "image"
  end

  create_table "listings", force: :cascade do |t|
    t.string   "name"
    t.string   "contact_name"
    t.string   "email"
    t.string   "phone"
    t.string   "website_url"
    t.string   "profile_image"
    t.string   "profile_description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.integer  "country_id"
    t.integer  "status"
    t.string   "slug"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.string   "postcode"
    t.text     "location_dump"
    t.integer  "validation_status"
    t.json     "images"
    t.json     "hero_images"
    t.string   "service_area"
    t.text     "teaser_description"
    t.boolean  "featured"
    t.boolean  "online_consultant"
    t.text     "service_search"
    t.string   "hidden_service_area"
    t.integer  "promos"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "photos", force: :cascade do |t|
    t.integer  "position"
    t.string   "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "gallery_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "description"
    t.string   "wholesale_price"
    t.integer  "status"
    t.string   "itemcode"
    t.string   "barcode"
    t.string   "handle"
    t.string   "image"
    t.string   "position"
    t.string   "rrp"
    t.string   "product_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
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
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "retailer_id"
    t.float    "customlongitude"
    t.float    "customlatitude"
    t.string   "trade_gecko"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

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
