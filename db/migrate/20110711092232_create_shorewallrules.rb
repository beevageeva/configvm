class CreateShorewallrules < ActiveRecord::Migration
  def self.up
    create_table :shorewallrules do |t|
			t.string :action
      t.integer :sourceinterface_id
      t.string :sourceipaddresslist
      t.integer :destinterface_id
      t.string :destipaddresslist
      t.string :destport
      t.string :protocoltype
      t.string :fwport

      t.timestamps
    end
  end

  def self.down
    drop_table :shorewallrules
  end
end
