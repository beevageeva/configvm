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

ActiveRecord::Schema.define(:version => 20110715110343) do

  create_table "hosts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hypervisors", :force => true do |t|
    t.string   "name"
    t.string   "virttype"
    t.integer  "host_id"
    t.integer  "bridgeinterface_id"
    t.integer  "netinterface_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interfaces", :force => true do |t|
    t.string   "ifname"
    t.string   "mac"
    t.string   "ipaddress"
    t.string   "shorewallname"
    t.string   "shorewalloptions"
    t.integer  "host_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shorewallpolicies", :force => true do |t|
    t.integer  "sourceinterface_id"
    t.integer  "destinterface_id"
    t.string   "action"
    t.string   "loglevel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shorewallrules", :force => true do |t|
    t.string   "action"
    t.integer  "sourceinterface_id"
    t.string   "sourceipaddresslist"
    t.integer  "destinterface_id"
    t.string   "destipaddresslist"
    t.string   "destport"
    t.string   "protocoltype"
    t.string   "fwport"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vms", :force => true do |t|
    t.string   "name"
    t.string   "uuid"
    t.integer  "mem"
    t.integer  "cpus"
    t.integer  "vncdisplay"
    t.string   "diskname"
    t.boolean  "enabled"
    t.integer  "interface_id"
    t.integer  "hypervisor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
