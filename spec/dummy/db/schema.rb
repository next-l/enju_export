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

ActiveRecord::Schema.define(version: 20140524014928) do

  create_table "export_file_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",       default: "{}"
    t.integer  "sort_key"
    t.integer  "export_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "export_file_transitions", ["export_file_id"], name: "index_export_file_transitions_on_export_file_id"
  add_index "export_file_transitions", ["sort_key", "export_file_id"], name: "index_export_file_transitions_on_sort_key_and_export_file_id", unique: true

  create_table "export_files", force: true do |t|
    t.string   "export_file_name"
    t.string   "export_content_type"
    t.string   "export_file_size"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "export_files", ["user_id"], name: "index_export_files_on_user_id"

  create_table "library_groups", force: true do |t|
    t.string   "name",                                                           null: false
    t.text     "display_name"
    t.string   "short_name",                                                     null: false
    t.string   "email"
    t.text     "my_networks"
    t.text     "login_banner"
    t.text     "note"
    t.integer  "valid_period_for_new_user",   default: 365,                      null: false
    t.boolean  "post_to_union_catalog",       default: false,                    null: false
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "admin_networks"
    t.boolean  "allow_bookmark_external_url", default: false,                    null: false
    t.integer  "position"
    t.string   "url",                         default: "http://localhost:3000/"
  end

  add_index "library_groups", ["short_name"], name: "index_library_groups_on_short_name"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_has_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "user_group_id"
    t.integer  "required_role_id"
    t.string   "username"
    t.text     "note"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
