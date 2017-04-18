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

ActiveRecord::Schema.define(version: 20170409144553) do

  create_table "employee", primary_key: "eid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "username",   limit: 45,             null: false
    t.string  "password",   limit: 45,             null: false
    t.string  "firstname",  limit: 45,             null: false
    t.string  "lastname",   limit: 45,             null: false
    t.integer "supervisor",            default: 0, null: false
    t.index ["eid"], name: "eid_UNIQUE", unique: true, using: :btree
    t.index ["username"], name: "employee_username_uindex", unique: true, using: :btree
  end

  create_table "employee_project", primary_key: ["eid", "pid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "eid", null: false
    t.integer "pid", null: false
  end

  create_table "projects", primary_key: "pid", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "pname",      limit: 45
    t.string "start_date", limit: 45
    t.string "end_date",   limit: 45
    t.string "location",   limit: 45
  end

end
