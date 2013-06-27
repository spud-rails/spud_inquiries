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

ActiveRecord::Schema.define(:version => 20130627121030) do

  create_table "spud_admin_permissions", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.boolean  "access"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "scope"
  end

  create_table "spud_inquiries", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "spud_inquiry_form_id"
    t.text     "recipients"
    t.string   "subject"
    t.boolean  "marked_as_read",       :default => false
  end

  add_index "spud_inquiries", ["marked_as_read"], :name => "idx_inquiry_read"
  add_index "spud_inquiries", ["spud_inquiry_form_id"], :name => "idx_inquiry_form"

  create_table "spud_inquiry_fields", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.integer  "spud_inquiry_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "spud_inquiry_fields", ["spud_inquiry_id"], :name => "inquiry_field_parent_id"

  create_table "spud_inquiry_form_fields", :force => true do |t|
    t.integer  "spud_inquiry_form_id"
    t.string   "field_type"
    t.string   "name"
    t.text     "options"
    t.string   "default_value"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "field_order"
    t.boolean  "required"
    t.string   "placeholder"
  end

  add_index "spud_inquiry_form_fields", ["field_order"], :name => "form_field_order"

  create_table "spud_inquiry_forms", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.text     "recipients"
    t.string   "subject"
    t.string   "url_name"
    t.text     "thank_you_content"
  end

  add_index "spud_inquiry_forms", ["url_name"], :name => "idx_form_url_name"

  create_table "spud_user_settings", :force => true do |t|
    t.integer  "spud_user_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "spud_users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "super_admin"
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "time_zone"
  end

  add_index "spud_users", ["email"], :name => "index_spud_users_on_email"
  add_index "spud_users", ["login"], :name => "index_spud_users_on_login"

end
