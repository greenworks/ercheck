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

ActiveRecord::Schema.define(:version => 20130125090413) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "conducts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.string   "pancard"
    t.date     "date_of_birth"
    t.integer  "university_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "created_by"
    t.integer  "approved_by"
    t.integer  "is_published"
    t.integer  "status_id"
    t.string   "ssc_marksheet_code"
    t.string   "surname"
    t.string   "mother_name"
    t.string   "father_name"
    t.string   "string"
    t.integer  "metric_passing_year"
    t.integer  "Board_id"
    t.string   "highest_qualification"
    t.string   "highest_qualification_passing_year"
    t.integer  "mobile"
    t.string   "res_landline"
  end

  create_table "employements", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "employer_id"
    t.date     "date_of_joining"
    t.date     "date_of_leaving"
    t.text     "exit_comments"
    t.integer  "rating"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "created_by"
    t.integer  "approved_by"
    t.integer  "is_published"
    t.integer  "status_id"
    t.string   "employee_code"
    t.date     "resignation_date"
    t.string   "designation"
    t.string   "department"
    t.string   "function"
    t.string   "recorded_address"
    t.integer  "severance_id"
    t.integer  "reason_id"
    t.text     "other_reason"
    t.integer  "termination_discharge_reason_id"
    t.text     "other_termination_discharge_reason"
    t.boolean  "regret_flag"
    t.integer  "rehire_flag_id"
    t.integer  "conduct_id"
    t.integer  "external_matter_history_id"
    t.integer  "history_impact_id"
    t.integer  "category_id"
    t.integer  "last_pms_performance_rating"
    t.integer  "previous_pms_year_performance_rating"
    t.integer  "before_previous_pms_year_performance_rating"
    t.decimal  "ctc_on_hire"
    t.decimal  "ctc_on_severance"
    t.integer  "notice_period_served_id"
    t.integer  "notice_period_paid_id"
    t.integer  "full_n_final_status_id"
    t.integer  "settlement_pending_side_id"
  end

  create_table "employers", :force => true do |t|
    t.string   "name"
    t.string   "employer_code"
    t.text     "address"
    t.string   "city"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "enquiries", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "company_name"
    t.string   "website"
    t.text     "message"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "external_matter_histories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "full_n_final_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "history_impacts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notice_period_paids", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notice_period_serveds", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reasons", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rehire_flags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "settlement_pending_sides", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "severances", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "termination_discharge_reasons", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "universities", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.integer  "role_id"
    t.integer  "manager_id"
    t.integer  "employer_id"
  end

end
