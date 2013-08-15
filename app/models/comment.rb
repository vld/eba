class Comment < ActiveRecord::Base
  belongs_to :manager
  belongs_to :issue
  attr_accessible :body
end
