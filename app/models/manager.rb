class Manager < ActiveRecord::Base
  has_secure_password
  attr_accessible :password, :username
  validates_presence_of :password, :on => :create
end
