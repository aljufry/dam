class CreateIntsubnets < ActiveRecord::Migration
  def change
    create_table :intsubnets do |t|
      t.references :user, :null => false
      t.references :entry, :null => false
      t.string "int_subnet", :limit => 255, :null => false
      t.string "ip", :limit => 255, :null => false
      t.string "device_name", :limit => 15, :null => false
      t.text "remarks"
      t.integer "entry_id"
      t.timestamps
    end
  end
end
