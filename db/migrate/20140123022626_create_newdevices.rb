class CreateNewdevices < ActiveRecord::Migration
  def up
    create_table :newdevices do |t|
      #t.references :user, :null => false
      t.string "device_type"
      t.boolean "device_name"
      t.boolean "host_name"
      t.boolean"model"
      t.boolean"platform"
      t.boolean "operating_system"
      t.boolean"serial_number"
      t.boolean "warranty"
      t.boolean "location"
      t.boolean"segment"
      t.boolean"application"
      t.boolean "username"
      t.boolean "password"
      t.boolean "remarks"
      t.string "author",:limit=>30
      t.string "update_author",:limit=>30
      t.timestamps
    end
  end
  def down
    drop_table(:newdevices)
  end
end
