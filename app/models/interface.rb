class Interface < ActiveRecord::Base
    # attr_accessible :title, :body
  attr_accessible :physical_label,:interface_name, :ip_add, :net_mask,:def_getaway, :pre_dns,:alter_dns,:hw_add, :remarks,:author,:update_author
  has_many :ip_subnet
  #belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  belongs_to :entry


  validates :ip_add,:net_mask,:def_getaway,
            #:presence => true,
            :length => {:maximum => 15},
            :format => {
            :allow_blank => true,
            :with => /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
            }

  #validates_presence_of :physical_label
  #validates :public_ip,
  #          :length => {:maximum => 15},
  #          :format => {
  #            :allow_blank => true,
  #            :with => /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  #          }
end
