class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      #t.references :user, :null => false
      t.references :subnet, :null => false
      t.string "device_name", :limit => 255
      t.string "host_name", :limit => 255
      t.string "device_type", :limit => 255
      t.string "model", :limit => 255
      t.string "platform", :limit=> 255
      t.string "operating_system", :limit => 100
      t.string "serial_number", :limit => 255
      t.date "warranty"
      t.string "location", :limit => 200
      t.string "segment", :limit => 100
      t.string "application", :limit => 100
      t.string "username", :limit => 255
      t.string "password", :limit => 255
      t.text "remarks"
      t.string "author",:limit=>30
      t.string "update_author",:limit=>30
     t.timestamps
    end
  end
end
