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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131219145848) do

  create_table "field_data", :force => true do |t|
    t.integer  "field_id",    :null => false
    t.integer  "response_id", :null => false
    t.string   "value",       :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "field_data", ["field_id"], :name => "index_field_data_on_field_id"
  add_index "field_data", ["response_id", "field_id"], :name => "index_field_data_on_response_id_and_field_id", :unique => true
  add_index "field_data", ["response_id"], :name => "index_field_data_on_response_id"

  create_table "field_options", :force => true do |t|
    t.integer  "field_id",                      :null => false
    t.string   "value",                         :null => false
    t.string   "label",                         :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "default",    :default => false, :null => false
  end

  add_index "field_options", ["field_id"], :name => "index_field_options_on_field_id"

  create_table "fields", :force => true do |t|
    t.string   "field_type", :null => false
    t.integer  "form_id",    :null => false
    t.string   "label"
    t.string   "default"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name",       :null => false
    t.integer  "pos",        :null => false
  end

  add_index "fields", ["form_id"], :name => "index_fields_on_form_id"
  add_index "fields", ["name", "form_id"], :name => "index_fields_on_name_and_form_id", :unique => true

  create_table "forms", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "description"
    t.integer  "author_id",   :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "forms", ["author_id"], :name => "index_forms_on_author_id"

  create_table "responses", :force => true do |t|
    t.boolean  "read",       :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "form_id"
  end

  add_index "responses", ["form_id"], :name => "index_responses_on_form_id"

  create_table "users", :force => true do |t|
    t.string   "username",                            :null => false
    t.string   "email",                               :null => false
    t.string   "password_digest",                     :null => false
    t.string   "session_token",                       :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "admin",            :default => false
    t.boolean  "activated",        :default => false, :null => false
    t.string   "activation_token"
    t.string   "recovery_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["session_token"], :name => "index_users_on_session_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
