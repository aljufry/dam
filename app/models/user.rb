class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :username, :viewer, :editor, :name, :usertype,:author,:update_author, :email
  attr_protected :password, :salt

  attr_accessor :plain_password

  has_many :entries
  has_many :subnets

  validates_presence_of :username, :email, :name
  validates_length_of  :username, :minimum => 4, :maximum => 25
  validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  #validates_presence_of :password
  #validates_length_of  :username, :maximum => 255
  #validates_length_of :password , :minimum => 8, :maximum => 25
  validates_length_of  :plain_password, :within => 8..50, :on => :create  
  validates_uniqueness_of :username
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  before_save :hash_plain_password
  after_save :clear_plain_password
  
  def self.authenticate(uname, pass)
    user = User.find_by_username(uname)
    if (user != nil)
      hashed_password = Security.hash_pass(pass, user.salt)      
      if hashed_password == user.password
        return user
      end
    end
    return false
  end
  
  private
  
  def hash_plain_password
    unless plain_password.blank?
      self.salt = Security.generate_salt
      self.password = Security.hash_pass(plain_password, salt)
    end    
  end
    
  def clear_plain_password
    self.plain_password = nil
  end
  
end
