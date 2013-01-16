class CreateHypervisors < ActiveRecord::Migration
  def self.up
    create_table :hypervisors do |t|
      t.string :name
      t.string :virttype

			t.references :host
			t.integer	:bridgeinterface_id			
			t.integer	:netinterface_id			

      t.timestamps
    end
  end

  def self.down
    drop_table :hypervisors
  end
end
