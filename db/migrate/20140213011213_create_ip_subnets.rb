class CreateIpSubnets < ActiveRecord::Migration
  def change
    create_table :ip_subnets do |t|
        t.references :user, :null => false
        t.references :interface, :null => false
        t.string "subnet", :limit => 255, :null => false
        t.string "ip", :limit => 255, :null => false
        t.text "remarks"
        t.timestamps
     end
  end
end
