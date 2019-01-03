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

ActiveRecord::Schema.define(version: 2018_12_26_213239) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "medication_times", force: :cascade do |t|
    t.integer "medication_id", null: false
    t.integer "day_of_week", default: 0, null: false
    t.integer "time_of_day", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medication_id"], name: "index_medication_times_on_medication_id"
  end

  create_table "medications", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.integer "quantity"
    t.text "directions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scheduled_alerts", force: :cascade do |t|
    t.integer "delayed_job_id", null: false
    t.integer "medication_time_id", null: false
    t.date "scheduled_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medication_time_id", "scheduled_date"], name: "idx_uniq_med_time_date", unique: true
    t.index ["medication_time_id"], name: "index_scheduled_alerts_on_medication_time_id"
  end

end
