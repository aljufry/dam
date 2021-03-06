class Entry < ActiveRecord::Base

  KEY = "x5-p8fzo7juV2R4DOc5MQ3AF83oUe3t7"

  attr_accessible :device_name,:device_type, :model, :operating_system, :serial_number,
  :warranty, :location, :segment, :application, :username,
  :password,:interface_type, :vendor, :remarks, :platform, :host_name, :update_author,:author, :cpuMib, :ramMib

  has_many  :connections
  has_many :monitorings
  has_many :interfaces
  has_many :logs
  #belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  belongs_to :subnet
  #has_and_belongs_to :tags

  #validates_presence_of :author
  #validates_presence_of :subnet
  #
  #validates_presence_of :device_name
  #validates_length_of  :device_name, :maximum => 255
  ##
  #validates_presence_of :model
  #validates_length_of  :model, :maximum => 255
  ##
  #validates_presence_of :operating_system
  #validates_length_of  :operating_system, :maximum => 100
  ##
  #validates_presence_of :serial_number
  #validates_length_of  :serial_number, :maximum => 255

  #validates :ip,
  #          :presence => true,
  #          :length => {:maximum => 15},
  #          :format => {
  #            :allow_blank => true,
  #            :with => /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  #          }
  #validates :public_ip,
  #          :length => {:maximum => 15},
  #          :format => {
  #            :allow_blank => true,
  #            :with => /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  #          }


  validate :warranty_is_valid_date

  before_save :encrypt_username_password
  after_save :decrypt_username_password
  after_find :decrypt_username_password

  private
  def encrypt_username_password
    if username != nil && username.length > 0
      self.username = Security.encrypt(KEY, self.username)
    end
    if password != nil && password.length > 0
      self.password = Security.encrypt(KEY, self.password)
    end
  end

  def decrypt_username_password
    key = "x5-p8fzo7juV2R4DOc5MQ3AF83oUe3t7"
    if username != nil && username.length > 0
      self.username = Security.decrypt(key, self.username)
    end
    if password != nil && password.length > 0
      self.password = Security.decrypt(key, self.password)
    end
  end

  def warranty_is_valid_date    
=begin    
    if :warranty.length > 0
    errors.add(:warranty, 'must be a valid date!!!') if ((Date.parse(:warranty) rescue ArgumentError) == ArgumentError)
    else
      
    end
=end    
  end
end
