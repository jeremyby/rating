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

ActiveRecord::Schema.define(:version => 20121116094821) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "token"
  end

  add_index "authorizations", ["user_id"], :name => "index_authorizations_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body",             :default => ""
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "countries", :force => true do |t|
    t.string   "slug"
    t.string   "code",            :null => false
    t.string   "name",            :null => false
    t.string   "alias"
    t.string   "full_name"
    t.integer  "polls_count"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "link"
    t.string   "pretty_name"
    t.integer  "watchings_count"
  end

  add_index "countries", ["code"], :name => "index_countries_on_code", :unique => true
  add_index "countries", ["name"], :name => "index_countries_on_name", :unique => true
  add_index "countries", ["slug"], :name => "index_countries_on_slug", :unique => true

  create_table "dbgraphs", :force => true do |t|
    t.text     "value"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "link"
  end

  create_table "facts", :force => true do |t|
    t.string   "value"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "polls", :force => true do |t|
    t.string   "slug"
    t.string   "question",                                  :null => false
    t.integer  "votings_count"
    t.string   "yes",                    :default => "Yes", :null => false
    t.string   "no",                     :default => "No",  :null => false
    t.boolean  "positive_no",            :default => false, :null => false
    t.integer  "user_id",                                   :null => false
    t.string   "country_code",                              :null => false
    t.string   "category",                                  :null => false
    t.integer  "coverage",               :default => 0,     :null => false
    t.integer  "weight",                 :default => -1,    :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "featured",               :default => false
    t.integer  "positive_votings_count"
    t.integer  "negative_votings_count"
  end

  add_index "polls", ["country_code"], :name => "index_polls_on_country_code"
  add_index "polls", ["user_id"], :name => "index_polls_on_user_id"

  create_table "scores", :force => true do |t|
    t.float    "value",          :default => 50.0, :null => false
    t.float    "previous_score"
    t.integer  "country_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "country_code",                          :null => false
    t.string   "persistence_token"
    t.integer  "login_count",        :default => 0,     :null => false
    t.integer  "failed_login_count", :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "avatar"
    t.boolean  "admin",              :default => false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["country_code"], :name => "index_users_on_country_code"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

  create_table "votings", :force => true do |t|
    t.integer  "poll_id",      :null => false
    t.integer  "user_id",      :null => false
    t.string   "country_code", :null => false
    t.integer  "vote",         :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votings", ["country_code"], :name => "index_votings_on_country_code"
  add_index "votings", ["poll_id"], :name => "index_votings_on_poll_id"
  add_index "votings", ["user_id"], :name => "index_votings_on_user_id"

  create_table "watchings", :force => true do |t|
    t.integer  "user_id"
    t.string   "country_code"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "watchings", ["country_code"], :name => "index_watchings_on_country_code"
  add_index "watchings", ["user_id", "country_code"], :name => "index_watchings_on_user_id_and_country_code", :unique => true
  add_index "watchings", ["user_id"], :name => "index_watchings_on_user_id"

end
