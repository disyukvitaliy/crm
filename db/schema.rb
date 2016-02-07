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

ActiveRecord::Schema.define(version: 20160207023811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "title"
    t.integer  "priority",      limit: 2, default: 0
    t.integer  "status",        limit: 2, default: 0
    t.integer  "element_order",           default: 0, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "issue_priorities", force: :cascade do |t|
    t.string   "title"
    t.integer  "priority",      limit: 2, default: 0
    t.integer  "status",        limit: 2, default: 0
    t.integer  "element_order",           default: 0, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "issue_statuses", force: :cascade do |t|
    t.string   "title"
    t.integer  "priority",      limit: 2, default: 0
    t.integer  "status",        limit: 2, default: 0
    t.integer  "issue_status",  limit: 2, default: 0
    t.integer  "element_order",           default: 0, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "issues", force: :cascade do |t|
    t.integer  "project_id"
    t.text     "subj"
    t.text     "descr"
    t.date     "start_date"
    t.date     "due_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "issue_status_id"
    t.integer  "issue_priority_id"
    t.float    "estimated_time"
  end

  add_index "issues", ["estimated_time"], name: "index_issues_on_estimated_time", using: :btree
  add_index "issues", ["issue_priority_id"], name: "index_issues_on_issue_priority_id", using: :btree
  add_index "issues", ["issue_status_id"], name: "index_issues_on_issue_status_id", using: :btree
  add_index "issues", ["project_id"], name: "index_issues_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.text     "title",                            null: false
    t.text     "descr"
    t.integer  "status",     limit: 2, default: 1
    t.integer  "parent_id"
    t.integer  "lft",                              null: false
    t.integer  "rgt",                              null: false
    t.integer  "depth",                default: 0, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "slug",                             null: false
  end

  add_index "projects", ["lft"], name: "index_projects_on_lft", using: :btree
  add_index "projects", ["parent_id"], name: "index_projects_on_parent_id", using: :btree
  add_index "projects", ["rgt"], name: "index_projects_on_rgt", using: :btree
  add_index "projects", ["slug"], name: "index_projects_on_slug", unique: true, using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "site_name"
    t.string   "host_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_entries", force: :cascade do |t|
    t.date     "date"
    t.float    "amount"
    t.text     "comment"
    t.integer  "activity_id"
    t.integer  "issue_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "time_entries", ["activity_id"], name: "index_time_entries_on_activity_id", using: :btree
  add_index "time_entries", ["amount"], name: "index_time_entries_on_amount", using: :btree
  add_index "time_entries", ["date"], name: "index_time_entries_on_date", using: :btree
  add_index "time_entries", ["issue_id"], name: "index_time_entries_on_issue_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean  "status",                 default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["status"], name: "index_users_on_status", using: :btree

  add_foreign_key "issues", "issue_priorities", name: "fk_issues_on_issue_priority_id", on_delete: :nullify
  add_foreign_key "issues", "issue_statuses", name: "fk_issues_on_issue_status_id", on_delete: :nullify
  add_foreign_key "issues", "projects", name: "fk_issues_on_project_id", on_delete: :restrict
  add_foreign_key "time_entries", "activities", name: "fk_time_entries_on_activity_id", on_delete: :nullify
  add_foreign_key "time_entries", "issues", name: "fk_time_entries_on_issue_id", on_delete: :cascade
end
