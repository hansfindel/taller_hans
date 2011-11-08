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

ActiveRecord::Schema.define(:version => 20111102202714) do

  create_table "alumns", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.float    "my_grade"
    t.float    "calification"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
    t.boolean  "oculto"
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"

  create_table "courses", :force => true do |t|
    t.string   "curso"
    t.integer  "agno"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "login_failures", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profesors", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", :force => true do |t|
    t.string   "type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "rut"
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "email"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "active"
  end

end
