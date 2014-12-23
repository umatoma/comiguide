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

ActiveRecord::Schema.define(version: 20141223141718) do

  create_table "api_tokens", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "token",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_tokens", ["token"], name: "index_api_tokens_on_token", unique: true, using: :btree
  add_index "api_tokens", ["user_id"], name: "index_api_tokens_on_user_id", unique: true, using: :btree

  create_table "c1blocks", force: true do |t|
    t.integer "comic1_id", null: false
    t.string  "name",      null: false
    t.integer "pos_x",     null: false
    t.integer "pos_y",     null: false
  end

  add_index "c1blocks", ["comic1_id"], name: "index_c1blocks_on_comic1_id", using: :btree
  add_index "c1blocks", ["pos_x"], name: "index_c1blocks_on_pos_x", using: :btree
  add_index "c1blocks", ["pos_y"], name: "index_c1blocks_on_pos_y", using: :btree

  create_table "c1circle_checklists", force: true do |t|
    t.integer  "user_id",                        null: false
    t.integer  "comic1_id",                      null: false
    t.integer  "c1layout_id",                    null: false
    t.integer  "space_no_sub",                   null: false
    t.string   "circle_name",                    null: false
    t.string   "circle_url"
    t.string   "comment"
    t.string   "cost"
    t.string   "color",        default: "black", null: false
    t.integer  "rank",         default: 1,       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "c1circle_checklists", ["c1layout_id"], name: "index_c1circle_checklists_on_c1layout_id", using: :btree
  add_index "c1circle_checklists", ["circle_name"], name: "index_c1circle_checklists_on_circle_name", using: :btree
  add_index "c1circle_checklists", ["color"], name: "index_c1circle_checklists_on_color", using: :btree
  add_index "c1circle_checklists", ["comic1_id"], name: "index_c1circle_checklists_on_comic1_id", using: :btree
  add_index "c1circle_checklists", ["rank"], name: "index_c1circle_checklists_on_rank", using: :btree
  add_index "c1circle_checklists", ["user_id"], name: "index_c1circle_checklists_on_user_id", using: :btree

  create_table "c1circles", force: true do |t|
    t.integer  "comic1_id",    null: false
    t.integer  "c1layout_id",  null: false
    t.integer  "space_no_sub", null: false
    t.string   "name",         null: false
    t.string   "kana",         null: false
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "c1circles", ["c1layout_id"], name: "index_c1circles_on_c1layout_id", using: :btree
  add_index "c1circles", ["comic1_id"], name: "index_c1circles_on_comic1_id", using: :btree
  add_index "c1circles", ["kana"], name: "index_c1circles_on_kana", using: :btree
  add_index "c1circles", ["name"], name: "index_c1circles_on_name", using: :btree

  create_table "c1layouts", force: true do |t|
    t.integer "c1block_id", null: false
    t.integer "space_no",   null: false
    t.integer "layout",     null: false
    t.integer "pos_x",      null: false
    t.integer "pos_y",      null: false
  end

  add_index "c1layouts", ["c1block_id"], name: "index_c1layouts_on_c1block_id", using: :btree
  add_index "c1layouts", ["layout"], name: "index_c1layouts_on_layout", using: :btree
  add_index "c1layouts", ["pos_x"], name: "index_c1layouts_on_pos_x", using: :btree
  add_index "c1layouts", ["pos_y"], name: "index_c1layouts_on_pos_y", using: :btree
  add_index "c1layouts", ["space_no"], name: "index_c1layouts_on_space_no", using: :btree

  create_table "careas", force: true do |t|
    t.integer "cmap_id",       null: false
    t.string  "name",          null: false
    t.string  "simple_name",   null: false
    t.string  "all_file_name"
    t.integer "pos_x",         null: false
    t.integer "pos_y",         null: false
    t.integer "size_w",        null: false
    t.integer "size_h",        null: false
    t.integer "pos_x2",        null: false
    t.integer "pos_y2",        null: false
    t.integer "size_w2",       null: false
    t.integer "size_h2",       null: false
  end

  add_index "careas", ["cmap_id"], name: "index_careas_on_cmap_id", using: :btree

  create_table "cblocks", force: true do |t|
    t.integer "carea_id", null: false
    t.string  "name",     null: false
    t.integer "pos_x",    null: false
    t.integer "pos_y",    null: false
  end

  add_index "cblocks", ["carea_id"], name: "index_cblocks_on_carea_id", using: :btree
  add_index "cblocks", ["pos_x"], name: "index_cblocks_on_pos_x", using: :btree
  add_index "cblocks", ["pos_y"], name: "index_cblocks_on_pos_y", using: :btree

  create_table "ccircle_checklists", force: true do |t|
    t.integer  "user_id",                        null: false
    t.integer  "comiket_id",                     null: false
    t.integer  "clayout_id",                     null: false
    t.integer  "space_no_sub", default: 0,       null: false
    t.integer  "day",                            null: false
    t.string   "circle_name",                    null: false
    t.string   "circle_url"
    t.string   "comment"
    t.string   "cost"
    t.string   "color",        default: "black", null: false
    t.integer  "rank",         default: 1,       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ccircle_checklists", ["circle_name"], name: "index_ccircle_checklists_on_circle_name", using: :btree
  add_index "ccircle_checklists", ["clayout_id"], name: "index_ccircle_checklists_on_clayout_id", using: :btree
  add_index "ccircle_checklists", ["color"], name: "index_ccircle_checklists_on_color", using: :btree
  add_index "ccircle_checklists", ["comiket_id"], name: "index_ccircle_checklists_on_comiket_id", using: :btree
  add_index "ccircle_checklists", ["day"], name: "index_ccircle_checklists_on_day", using: :btree
  add_index "ccircle_checklists", ["rank"], name: "index_ccircle_checklists_on_rank", using: :btree
  add_index "ccircle_checklists", ["user_id"], name: "index_ccircle_checklists_on_user_id", using: :btree

  create_table "ckigyo_checklists", force: true do |t|
    t.integer  "user_id",                      null: false
    t.integer  "ckigyo_id",                    null: false
    t.string   "comment"
    t.string   "cost"
    t.string   "color",      default: "black", null: false
    t.integer  "rank",       default: 1,       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckigyo_checklists", ["ckigyo_id"], name: "index_ckigyo_checklists_on_ckigyo_id", using: :btree
  add_index "ckigyo_checklists", ["color"], name: "index_ckigyo_checklists_on_color", using: :btree
  add_index "ckigyo_checklists", ["rank"], name: "index_ckigyo_checklists_on_rank", using: :btree
  add_index "ckigyo_checklists", ["user_id"], name: "index_ckigyo_checklists_on_user_id", using: :btree

  create_table "ckigyo_links", force: true do |t|
    t.integer  "ckigyo_id",  null: false
    t.string   "url",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckigyo_links", ["ckigyo_id", "url"], name: "index_ckigyo_links_on_ckigyo_id_and_url", unique: true, using: :btree
  add_index "ckigyo_links", ["ckigyo_id"], name: "index_ckigyo_links_on_ckigyo_id", using: :btree

  create_table "ckigyos", force: true do |t|
    t.integer "comiket_id",             null: false
    t.integer "kigyo_no",               null: false
    t.string  "name",                   null: false
    t.integer "x",                      null: false
    t.integer "y",                      null: false
    t.integer "w",          default: 1, null: false
    t.integer "h",          default: 1, null: false
  end

  add_index "ckigyos", ["comiket_id", "kigyo_no"], name: "index_ckigyos_on_comiket_id_and_kigyo_no", unique: true, using: :btree
  add_index "ckigyos", ["comiket_id"], name: "index_ckigyos_on_comiket_id", using: :btree
  add_index "ckigyos", ["kigyo_no"], name: "index_ckigyos_on_kigyo_no", using: :btree

  create_table "clayouts", force: true do |t|
    t.integer "cblock_id", null: false
    t.integer "space_no",  null: false
    t.integer "layout",    null: false
    t.integer "pos_x",     null: false
    t.integer "pos_y",     null: false
  end

  add_index "clayouts", ["cblock_id"], name: "index_clayouts_on_cblock_id", using: :btree
  add_index "clayouts", ["layout"], name: "index_clayouts_on_layout", using: :btree
  add_index "clayouts", ["pos_x"], name: "index_clayouts_on_pos_x", using: :btree
  add_index "clayouts", ["pos_y"], name: "index_clayouts_on_pos_y", using: :btree
  add_index "clayouts", ["space_no"], name: "index_clayouts_on_space_no", using: :btree

  create_table "comic1s", force: true do |t|
    t.integer "event_no",   null: false
    t.string  "event_name", null: false
  end

  add_index "comic1s", ["event_no"], name: "index_comic1s_on_event_no", unique: true, using: :btree

  create_table "comikets", force: true do |t|
    t.integer "event_no",   null: false
    t.string  "event_name", null: false
    t.integer "kigyo_w",    null: false
    t.integer "kigyo_h",    null: false
  end

  add_index "comikets", ["event_no"], name: "index_comikets_on_event_no", unique: true, using: :btree

  create_table "notifications", force: true do |t|
    t.string   "title",                    null: false
    t.text     "content",                  null: false
    t.integer  "status",       default: 1, null: false
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["status"], name: "index_notifications_on_status", using: :btree
  add_index "notifications", ["title"], name: "index_notifications_on_title", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",                            null: false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
