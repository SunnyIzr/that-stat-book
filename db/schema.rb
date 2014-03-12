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

ActiveRecord::Schema.define(version: 20140311015618) do

  create_table "answer_submissions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quiz_id"
    t.integer  "choice_id"
  end

  add_index "answer_submissions", ["choice_id"], name: "index_answer_submissions_on_choice_id", using: :btree
  add_index "answer_submissions", ["quiz_id"], name: "index_answer_submissions_on_quiz_id", using: :btree

  create_table "choices", force: true do |t|
    t.text     "choice"
    t.boolean  "is_correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.text     "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lesson_id"
  end

  add_index "questions", ["lesson_id"], name: "index_questions_on_lesson_id", using: :btree

  create_table "quizzes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "lesson_id"
  end

  add_index "quizzes", ["lesson_id"], name: "index_quizzes_on_lesson_id", using: :btree
  add_index "quizzes", ["user_id"], name: "index_quizzes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
  end

end
