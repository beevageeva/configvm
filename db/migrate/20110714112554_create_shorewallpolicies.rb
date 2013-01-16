class CreateShorewallpolicies < ActiveRecord::Migration
  def self.up
    create_table :shorewallpolicies do |t|
      t.integer :sourceinterface_id
      t.integer :destinterface_id
      t.string :action
      t.string :loglevel


      t.timestamps
    end
  end

  def self.down
    drop_table :shorewallpolicies
  end
end
