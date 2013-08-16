class Comment < ActiveRecord::Base
  belongs_to :manager
  belongs_to :issue
  attr_accessible :body
  after_create :mail_owner

  def mail_owner
    CustomerMailer.commented_email(self.issue).deliver
  end
end
