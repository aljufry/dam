class Subnet < ActiveRecord::Base
  attr_accessible :name, :cidr, :description, :author, :update_author
  has_many :agents
  has_many  :entries
  has_many :connections
  #belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  
  #validates_presence_of :author
  
  #validates_presence_of :name, :message => "haha"
  #validates_length_of  :name, :maximum => 100
  
  validates_presence_of :cidr, :name
  validates_length_of  :cidr, :maximum => 50
    
  #validates_format_of :cidr, :with => /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\/(\d|[1-2]\d|3[0-2]))$/
  
end
