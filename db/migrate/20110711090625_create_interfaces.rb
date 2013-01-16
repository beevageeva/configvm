class CreateInterfaces < ActiveRecord::Migration
  def self.up
    create_table :interfaces do |t|
      t.string :ifname
      t.string :mac
      t.string :ipaddress
      t.string :shorewallname
      t.string :shorewalloptions

			t.references :host			

      t.timestamps
    end
  end

  def self.down
    drop_table :interfaces
  end
end
