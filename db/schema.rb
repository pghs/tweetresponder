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

ActiveRecord::Schema.define(:version => 20120709142735) do

  create_table "questions", :force => true do |t|
    t.integer  "q_id"
    t.integer  "lesson_id"
    t.text     "question"
    t.text     "answer"
    t.text     "tweet"
    t.text     "url"
    t.text     "short_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "next"
    t.string   "tweet_id"
  end

  create_table "tweets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "message"
    t.boolean  "answered",              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "in_reply_to_status_id"
    t.string   "in_reply_to_user_id"
    t.integer  "t_id"
  end

  create_table "users", :force => true do |t|
    t.integer  "t_id"
    t.string   "t_name"
    t.string   "t_screen_name"
    t.integer  "lifetime_score"
    t.integer  "weekly_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
