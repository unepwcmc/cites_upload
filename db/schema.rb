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

ActiveRecord::Schema.define(:version => 20111212112207) do

  create_table "reports", :force => true do |t|
    t.string   "country"
    t.integer  "year"
    t.integer  "basis"
    t.string   "contact_details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_exports"
    t.boolean  "has_imports"
  end

  create_table "uploaded_files", :force => true do |t|
    t.integer  "file_type"
    t.integer  "report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

end
