class Connection < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :device_name, :model, :serial_number, :ip, :warranty, :location, :application,
                  :username, :password, :remarks

  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  belongs_to :subnet

end
