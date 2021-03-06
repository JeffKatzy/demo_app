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

ActiveRecord::Schema.define(:version => 20130426034610) do

  create_table "assignments", :force => true do |t|
    t.integer  "lecture_id"
    t.integer  "classroom_id"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "completed"
  end

  create_table "calls", :force => true do |t|
    t.string   "to"
    t.string   "from"
    t.string   "called"
    t.string   "account_sid"
    t.string   "call_sid"
    t.string   "call_status"
    t.string   "caller"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "state"
    t.string   "digits"
    t.integer  "user_id"
    t.integer  "assignment_id"
  end

  create_table "classroom_designations", :force => true do |t|
    t.integer  "classroom_id"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "classrooms", :force => true do |t|
    t.integer  "teacher_id"
    t.string   "name"
    t.integer  "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "random"
  end

  create_table "explanations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "question_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "soundfile_file_name"
    t.string   "soundfile_content_type"
    t.integer  "soundfile_file_size"
    t.datetime "soundfile_updated_at"
  end

  create_table "lectures", :force => true do |t|
    t.integer  "lesson_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "soundfile_file_name"
    t.string   "soundfile_content_type"
    t.integer  "soundfile_file_size"
    t.datetime "soundfile_updated_at"
  end

  create_table "lessons", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "answer"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "soundfile_file_name"
    t.string   "soundfile_content_type"
    t.integer  "soundfile_file_size"
    t.datetime "soundfile_updated_at"
    t.integer  "lecture_id"
    t.string   "explanationfile_file_name"
    t.string   "explanationfile_content_type"
    t.integer  "explanationfile_file_size"
    t.datetime "explanationfile_updated_at"
  end

  create_table "sms", :force => true do |t|
    t.string   "incoming_number"
    t.string   "content_received"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "teachers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "teachers", ["remember_token"], :name => "index_teachers_on_remember_token"

  create_table "texts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_answers", :force => true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "correct"
    t.integer  "user_lecture_id"
  end

  create_table "user_lectures", :force => true do |t|
    t.integer  "lecture_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
    t.datetime "end_time"
    t.integer  "assignment_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "cell_number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "lecture_id"
    t.integer  "question_id"
    t.integer  "assignment_id"
  end

end
