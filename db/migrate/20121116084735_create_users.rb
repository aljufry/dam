class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "username", :limit => 255, :null => false
      t.string "password", :limit => 255, :null => false
      t.string "usertype", :limit => 200, :null => false
      t.boolean "editor", :default => false
      t.boolean "viewer", :default => true
      t.string "name", :limit => 200, :null => false
      t.string "email", :limit => 200, :null => false
      t.string "salt", :limit=>100,:null=>false
      t.string "author", :limit=>30
      t.string "update_author", :limit=>30
      t.timestamps
    end
  end
end
