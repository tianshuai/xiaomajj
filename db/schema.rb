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

ActiveRecord::Schema.define(version: 20141110105054) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "answers", force: true do |t|
    t.text     "tip"
    t.string   "audio_url"
    t.string   "audio_length"
    t.integer  "question_bank_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_bank_id"], name: "index_answers_on_question_bank_id", using: :btree

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.datetime "expires_at"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id", using: :btree

  create_table "blocks", force: true do |t|
    t.string   "title",                  null: false
    t.text     "content"
    t.string   "mark",                   null: false
    t.integer  "status",     default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blocks", ["mark"], name: "index_blocks_on_mark", unique: true, using: :btree

  create_table "captchas", force: true do |t|
    t.string   "title"
    t.string   "code"
    t.integer  "kind",       default: 1, null: false
    t.integer  "expires_at"
    t.integer  "user_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "captchas", ["code"], name: "index_captchas_on_code", using: :btree
  add_index "captchas", ["expires_at"], name: "index_captchas_on_expires_at", using: :btree
  add_index "captchas", ["user_id"], name: "index_captchas_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "status",          default: 1, null: false
    t.integer  "relateable_id"
    t.string   "relateable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opinions", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "question_bank_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opinions", ["question_bank_id"], name: "index_opinions_on_question_bank_id", using: :btree
  add_index "opinions", ["user_id"], name: "index_opinions_on_user_id", using: :btree

  create_table "practises", force: true do |t|
    t.string   "audio_url"
    t.string   "audio_length"
    t.integer  "user_id"
    t.integer  "question_bank_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "practises", ["question_bank_id"], name: "index_practises_on_question_bank_id", using: :btree
  add_index "practises", ["user_id"], name: "index_practises_on_user_id", using: :btree

  create_table "question_banks", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "tags"
    t.string   "number",     null: false
    t.string   "video_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "question_banks", ["number"], name: "index_question_banks_on_number", unique: true, using: :btree

  create_table "question_lists", force: true do |t|
    t.integer  "year"
    t.integer  "month"
    t.integer  "day",                    default: 1
    t.integer  "kind",                   default: 1
    t.string   "number_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alone_number_ids"
    t.string   "synthetical_number_ids"
    t.integer  "status",                 default: 1, null: false
  end

  add_index "question_lists", ["alone_number_ids"], name: "index_question_lists_on_alone_number_ids", using: :btree
  add_index "question_lists", ["day"], name: "index_question_lists_on_day", using: :btree
  add_index "question_lists", ["month"], name: "index_question_lists_on_month", using: :btree
  add_index "question_lists", ["number_ids"], name: "index_question_lists_on_number_ids", using: :btree
  add_index "question_lists", ["synthetical_number_ids"], name: "index_question_lists_on_synthetical_number_ids", using: :btree
  add_index "question_lists", ["year"], name: "index_question_lists_on_year", using: :btree

  create_table "questions", force: true do |t|
    t.string   "month"
    t.string   "number"
    t.string   "title"
    t.text     "content"
    t.string   "video_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", force: true do |t|
    t.string   "audio_url"
    t.string   "audio_length"
    t.integer  "user_id"
    t.integer  "question_bank_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "records", ["question_bank_id"], name: "index_records_on_question_bank_id", using: :btree
  add_index "records", ["user_id"], name: "index_records_on_user_id", using: :btree

  create_table "third_apis", force: true do |t|
    t.string   "uid"
    t.integer  "user_id"
    t.string   "access_token"
    t.integer  "expires_in"
    t.integer  "kind",          default: 1, null: false
    t.string   "refresh_token"
    t.integer  "status",        default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "login",                  null: false
    t.string   "email"
    t.integer  "kind",       default: 1, null: false
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.integer  "status",     default: 1, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["login"], name: "index_users_on_login", using: :btree
  add_index "users", ["phone"], name: "index_users_on_phone", using: :btree

  create_table "write_records", force: true do |t|
    t.text     "content"
    t.integer  "kind",            default: 1, null: false
    t.integer  "user_id",                     null: false
    t.integer  "writing_bank_id",             null: false
    t.integer  "status",          default: 1, null: false
    t.integer  "is_amend",        default: 0, null: false
    t.integer  "is_modify",       default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "write_records", ["user_id"], name: "index_write_records_on_user_id", using: :btree
  add_index "write_records", ["writing_bank_id"], name: "index_write_records_on_writing_bank_id", using: :btree

  create_table "writing_banks", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "kind",       default: 1, null: false
    t.integer  "status",     default: 1, null: false
    t.string   "number",                 null: false
    t.string   "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_url"
  end

  add_index "writing_banks", ["number"], name: "index_writing_banks_on_number", unique: true, using: :btree

end
