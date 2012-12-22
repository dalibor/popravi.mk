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

ActiveRecord::Schema.define(:version => 20121222162538) do

  create_table "api_keys", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "attachments", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "problems_count"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.boolean  "approved",         :default => true
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "commentable_type"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "contacts", :force => true do |t|
    t.integer  "municipality_id"
    t.text     "about"
    t.string   "address"
    t.string   "phone"
    t.string   "web"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "municipalities", :force => true do |t|
    t.integer  "region_id"
    t.string   "name"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "problems_count",     :default => 0
    t.string   "slug"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "slug"
    t.string   "title"
    t.text     "content"
    t.datetime "published_at"
    t.boolean  "comments_closed"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "published",       :default => true
  end

  create_table "problem_transitions", :force => true do |t|
    t.integer  "problem_id"
    t.string   "from"
    t.string   "to"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "problems", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "municipality_id"
    t.text     "description"
    t.string   "status",             :default => "0"
    t.string   "longitude"
    t.string   "latitude"
    t.string   "email"
    t.string   "device_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "weight",             :default => 5
    t.datetime "sent_at"
    t.text     "official_notes"
    t.datetime "solved_at"
    t.integer  "last_editor_id"
    t.string   "token"
    t.integer  "api_key_id"
    t.integer  "rates_count",        :default => 0
  end

  add_index "problems", ["email"], :name => "index_problems_on_email"

  create_table "rates", :force => true do |t|
    t.integer  "problem_id"
    t.integer  "user_id"
    t.integer  "weight"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "regions", :force => true do |t|
    t.integer  "country_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.boolean  "is_admin",               :default => false
    t.integer  "problems_count",         :default => 0
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "password_salt",          :default => "",    :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "municipality_id"
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
