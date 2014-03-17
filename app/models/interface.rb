class Interface < ActiveRecord::Base
    # attr_accessible :title, :body
  attr_accessible :physical_label,:interface_name, :ip_add, :net_mask, :dns,:hw_add, :remarks
  has_many :ip_subnet
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  belongs_to :entry

end
