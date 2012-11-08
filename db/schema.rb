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

ActiveRecord::Schema.define(:version => 20121108035928) do

  create_table "calls", :force => true do |t|
    t.string   "to"
    t.string   "from"
    t.string   "called"
    t.string   "account_sid"
    t.string   "call_sid"
    t.string   "call_status"
    t.string   "caller"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "digits"
    t.integer  "user_id"
  end

  create_table "lectures", :force => true do |t|
    t.integer  "lesson_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "soundfile_file_name"
    t.string   "soundfile_content_type"
    t.integer  "soundfile_file_size"
    t.datetime "soundfile_updated_at"
  end

  create_table "lessons", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "lesson_id"
    t.string   "name"
    t.text     "description"
    t.integer  "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "soundfile_file_name"
    t.string   "soundfile_content_type"
    t.integer  "soundfile_file_size"
    t.datetime "soundfile_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "cell_number"
    t.integer  "lesson_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
