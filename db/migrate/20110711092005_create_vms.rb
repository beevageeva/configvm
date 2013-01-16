class CreateVms < ActiveRecord::Migration
  def self.up
    create_table :vms do |t|
      t.string :name
      t.string :uuid
      t.integer :mem
      t.integer :cpus
      t.integer :vncdisplay
      t.string :diskname
      t.boolean :enabled
			
			t.references :interface
			t.references :hypervisor


      t.timestamps
    end
  end

  def self.down
    drop_table :vms
  end
end
