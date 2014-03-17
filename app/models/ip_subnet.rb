class IpSubnet < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :ip, :subnet, :remarks
  belongs_to :author, :class_name=>"User", :foreign_key =>"user_id"
  belongs_to :interface
end
