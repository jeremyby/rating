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

ActiveRecord::Schema.define(:version => 20130620052301) do

  create_table "answerable_translations", :force => true do |t|
    t.integer  "answerable_id"
    t.string   "locale"
    t.text     "body"
    t.string   "auto_translated"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "answerable_translations", ["answerable_id"], :name => "index_answerable_translations_on_answerable_id"
  add_index "answerable_translations", ["locale"], :name => "index_answerable_translations_on_locale"

  create_table "answerables", :force => true do |t|
    t.string   "type"
    t.integer  "askable_id",      :null => false
    t.integer  "user_id",         :null => false
    t.string   "country_code",    :null => false
    t.text     "body"
    t.string   "auto_translated"
    t.integer  "vote"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "answerables", ["askable_id"], :name => "index_answerables_on_askable_id"
  add_index "answerables", ["country_code"], :name => "index_answerables_on_country_code"
  add_index "answerables", ["user_id", "askable_id", "country_code"], :name => "index_answerables_on_user_id_and_askable_id_and_country_code", :unique => true
  add_index "answerables", ["user_id"], :name => "index_answerables_on_user_id"

  create_table "askable_translations", :force => true do |t|
    t.integer  "askable_id"
    t.string   "locale"
    t.string   "slug"
    t.text     "body"
    t.text     "description"
    t.string   "yes"
    t.string   "no"
    t.string   "auto_translated"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "askable_translations", ["askable_id"], :name => "index_askable_translations_on_askable_id"
  add_index "askable_translations", ["locale"], :name => "index_askable_translations_on_locale"

  create_table "askables", :force => true do |t|
    t.string   "type"
    t.string   "country_code",                        :null => false
    t.integer  "followings_count", :default => 0
    t.integer  "user_id",                             :null => false
    t.string   "slug"
    t.text     "body",                                :null => false
    t.integer  "coverage",         :default => 0,     :null => false
    t.boolean  "featured",         :default => false
    t.boolean  "locked",           :default => false
    t.string   "auto_translated"
    t.text     "description"
    t.string   "yes",              :default => "Yes"
    t.string   "no",               :default => "No"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "askables", ["country_code"], :name => "index_askables_on_country_code"
  add_index "askables", ["slug"], :name => "index_askables_on_slug", :unique => true
  add_index "askables", ["user_id"], :name => "index_askables_on_user_id"

  create_table "authorizations", :force => true do |t|
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.integer  "user_id",    :null => false
    t.text     "token",      :null => false
    t.text     "link",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authorizations", ["user_id"], :name => "index_authorizations_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body"
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
    t.string   "code",                               :null => false
    t.string   "name",                               :null => false
    t.string   "pretty_name"
    t.string   "alias"
    t.string   "full_name"
    t.string   "language",         :default => "en"
    t.string   "searchable"
    t.text     "link"
    t.integer  "askables_count"
    t.integer  "followings_count"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "countries", ["code"], :name => "index_countries_on_code", :unique => true
  add_index "countries", ["name"], :name => "index_countries_on_name", :unique => true
  add_index "countries", ["slug"], :name => "index_countries_on_slug", :unique => true

  create_table "country_translations", :force => true do |t|
    t.integer  "country_id"
    t.string   "locale"
    t.string   "slug"
    t.string   "name"
    t.string   "full_name"
    t.string   "alias"
    t.string   "pretty_name"
    t.string   "searchable"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "country_translations", ["country_id"], :name => "index_country_translations_on_country_id"
  add_index "country_translations", ["locale"], :name => "index_country_translations_on_locale"

  create_table "dbgraphs", :force => true do |t|
    t.text     "value",      :limit => 2147483647
    t.integer  "country_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "dbgraphs", ["country_id"], :name => "index_dbgraphs_on_country_id", :unique => true

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.string   "kind",          :null => false
    t.string   "country_code",  :null => false
    t.integer  "askable_id",    :null => false
    t.integer  "user_id"
    t.integer  "answerable_id"
    t.string   "locales"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "events", ["askable_id"], :name => "index_events_on_askable_id"
  add_index "events", ["country_code", "askable_id", "user_id"], :name => "index_events_on_country_code_and_askable_id_and_user_id"
  add_index "events", ["country_code"], :name => "index_events_on_country_code"

  create_table "facts", :force => true do |t|
    t.string   "value"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "facts", ["country_id"], :name => "index_facts_on_country_id"

  create_table "followings", :force => true do |t|
    t.integer  "user_id",         :null => false
    t.integer  "followable_id"
    t.string   "followable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "followings", ["followable_id", "followable_type"], :name => "index_followings_on_followable_id_and_followable_type"
  add_index "followings", ["user_id"], :name => "index_followings_on_user_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "results", :force => true do |t|
    t.integer  "poll_id"
    t.integer  "yes_count"
    t.integer  "no_count"
    t.string   "country_code"
    t.string   "date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "results", ["poll_id"], :name => "index_results_on_poll_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "country_code",                          :null => false
    t.string   "avatar"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",              :default => false
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
  end

  add_index "users", ["country_code"], :name => "index_users_on_country_code"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.string   "locale"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false, :null => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], :name => "fk_one_vote_per_user_per_entity", :unique => true
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
