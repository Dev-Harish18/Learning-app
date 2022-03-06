# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_03_04_100855) do
  create_table "attempted_questions", force: :cascade do |t|
    t.string "submitted_answer"
    t.integer "score",default:0
    t.integer "attempt_id", null: false
    t.integer "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_attempted_questions_on_attempt_id"
    t.index ["question_id"], name: "index_attempted_questions_on_question_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.integer "time_spent"
    t.integer "total_score"
    t.integer "user_id", null: false
    t.integer "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_attempts_on_exercise_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string "name"
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_chapters_on_subject_id"
  end

  create_table "contents", force: :cascade do |t|
    t.string "title"
    t.string "file_type"
    t.string "path"
    t.string "description"
    t.integer "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_contents_on_chapter_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.string "duration"
    t.integer "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_exercises_on_chapter_id"
  end

  create_table "grades", force: :cascade do |t|
    t.integer "standard"
    t.integer "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_grades_on_board_id"
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.string "correct_option"
    t.string "option1"
    t.string "option2"
    t.string "option3"
    t.integer "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_questions_on_exercise_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.integer "grade_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_id"], name: "index_subjects_on_grade_id"
  end

  create_table "user_contents", force: :cascade do |t|
    t.string "notes", default: "Write your notes here"
    t.boolean "upvoted", default: false
    t.boolean "downvoted", default: false
    t.integer "user_id", null: false
    t.integer "content_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_user_contents_on_content_id"
    t.index ["user_id"], name: "index_user_contents_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "mobile"
    t.string "email"
    t.date "dob"
    t.string "password_digest"
    t.integer "board_id"
    t.integer "grade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_users_on_board_id"
    t.index ["grade_id"], name: "index_users_on_grade_id"
  end

  add_foreign_key "attempted_questions", "attempts"
  add_foreign_key "attempted_questions", "questions"
  add_foreign_key "attempts", "exercises"
  add_foreign_key "attempts", "users"
  add_foreign_key "chapters", "subjects"
  add_foreign_key "contents", "chapters"
  add_foreign_key "exercises", "chapters"
  add_foreign_key "grades", "boards"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "questions", "exercises"
  add_foreign_key "subjects", "grades"
  add_foreign_key "user_contents", "contents"
  add_foreign_key "user_contents", "users"
  add_foreign_key "users", "boards"
  add_foreign_key "users", "grades"
end
