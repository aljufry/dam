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

ActiveRecord::Schema.define(:version => 20140306073155) do

  create_table "agents", :force => true do |t|
    t.string   "ip_address"
    t.text     "mibs"
    t.string   "name"
    t.string   "community"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "agents_mibs", :id => false, :force => true do |t|
    t.integer "agent_id"
    t.integer "mib_id"
    t.integer "mib_objects"
  end

  create_table "entries", :force => true do |t|
    t.integer  "user_id",                         :null => false
    t.integer  "subnet_id",                       :null => false
    t.string   "device_name"
    t.string   "host_name"
    t.string   "device_type"
    t.string   "model"
    t.string   "platform"
    t.string   "operating_system", :limit => 100
    t.string   "serial_number"
    t.date     "warranty"
    t.string   "location",         :limit => 200
    t.string   "segment",          :limit => 100
    t.string   "application",      :limit => 100
    t.string   "username"
    t.string   "password"
    t.text     "remarks"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "entries_tags", :id => false, :force => true do |t|
    t.integer "entry_id"
    t.integer "tag_id"
  end

  add_index "entries_tags", ["entry_id", "tag_id"], :name => "index_entries_tags_on_entry_id_and_tag_id"

  create_table "interfaces", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "entry_id",                      :null => false
    t.string   "physical_label",                :null => false
    t.string   "interface_name", :limit => 200
    t.string   "ip_add",         :limit => 100
    t.string   "net_mask"
    t.string   "dns"
    t.string   "hw_add"
    t.string   "remarks"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "ip_subnets", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.integer  "interface_id", :null => false
    t.string   "subnet",       :null => false
    t.string   "ip",           :null => false
    t.text     "remarks"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "newdevices", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.string   "device_type"
    t.boolean  "device_name"
    t.boolean  "host_name"
    t.boolean  "model"
    t.boolean  "platform"
    t.boolean  "operating_system"
    t.boolean  "serial_number"
    t.boolean  "warranty"
    t.boolean  "location"
    t.boolean  "segment"
    t.boolean  "application"
    t.boolean  "username"
    t.boolean  "password"
    t.boolean  "remarks"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "snmps", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subnets", :force => true do |t|
    t.string   "name",        :limit => 100, :null => false
    t.string   "cidr",        :limit => 20,  :null => false
    t.string   "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "user_id",                    :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "traps", :force => true do |t|
    t.string   "uptime"
    t.string   "oid"
    t.integer  "agent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                     :null => false
    t.string   "password",                                     :null => false
    t.string   "usertype",   :limit => 200,                    :null => false
    t.boolean  "editor",                    :default => false
    t.boolean  "viewer",                    :default => true
    t.string   "name",       :limit => 200
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "salt",       :limit => 100,                    :null => false
  end

end
