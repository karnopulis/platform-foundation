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

ActiveRecord::Schema.define(version: 20170609101647) do

  create_table "cart_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "variant_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "cart_id"
    t.integer  "ku"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
    t.index ["variant_id"], name: "index_cart_items_on_variant_id", using: :btree
  end

  create_table "carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "total"
    t.float    "total_price", limit: 24
  end

  create_table "characteristics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id",  null: false
    t.integer  "property_id", null: false
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["product_id"], name: "index_characteristics_on_product_id", using: :btree
    t.index ["property_id"], name: "index_characteristics_on_property_id", using: :btree
  end

  create_table "collections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "hidden"
    t.integer  "parent"
    t.integer  "position"
    t.integer  "sort"
    t.string   "title"
    t.string   "permalink"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title", "parent"], name: "index_collections_on_title_and_parent", unique: true, using: :btree
  end

  create_table "collects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id",    null: false
    t.integer  "collection_id", null: false
    t.integer  "position"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["collection_id"], name: "index_collects_on_collection_id", using: :btree
    t.index ["product_id"], name: "index_collects_on_product_id", using: :btree
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "position"
    t.string   "url"
    t.string   "original_url"
    t.string   "thumb_url"
    t.string   "filename"
    t.integer  "product_id",   null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "size"
    t.index ["product_id", "position"], name: "index_images_on_product_id_and_position", unique: true, using: :btree
    t.index ["product_id"], name: "index_images_on_product_id", using: :btree
  end

  create_table "prices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "value",      limit: 24
    t.integer  "variant_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "type"
    t.string   "name"
    t.index ["variant_id", "name"], name: "index_prices_on_variant_id_and_name", unique: true, using: :btree
    t.index ["variant_id"], name: "index_prices_on_variant_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "hidden"
    t.float    "sort_weight", limit: 24
    t.string   "title"
    t.string   "permalink"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "properties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "permalink"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_properties_on_title", unique: true, using: :btree
  end

  create_table "variants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "sku"
    t.integer  "quantity"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_variants_on_product_id", using: :btree
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "variants"
  add_foreign_key "characteristics", "products"
  add_foreign_key "characteristics", "properties"
end
