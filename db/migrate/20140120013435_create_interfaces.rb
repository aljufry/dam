class CreateInterfaces < ActiveRecord::Migration
  def change
    create_table :interfaces do |t|
        #t.references :user, :null => false
        t.references :entry, :null => false
        t.string "physical_label", :limit => 255, :null => false
        t.string "interface_name", :limit => 200
        t.string "ip_add", :limit => 100
        t.string"net_mask"
        t.string "def_getaway"
        t.string "pre_dns"
        t.string "alter_dns"
        t.string "hw_add"
        t.string"remarks"
        t.string "author",:limit=>30
        t.string "update_author",:limit=>30

      t.timestamps
    end
  end
end
