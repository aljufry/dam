class Newdevice < ActiveRecord::Base
  # attr_accessible :title, :body
    attr_accessible :device_name,:device_type, :model, :operating_system, :serial_number,
                    :warranty, :location, :segment, :application, :username,
                    :password,:interface_type, :vendor, :remarks, :host_name , :platform
    belongs_to :author, :class_name => "User", :foreign_key => "user_id"
end
