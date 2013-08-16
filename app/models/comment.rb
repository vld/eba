class Comment < ActiveRecord::Base
  belongs_to :manager
  belongs_to :issue
  attr_accessible :body
  after_create :mail_owner

  def mail_owner
    owner_mail = self.issue.customer_email
    body = self.body
    p "Send mail to #{owner_mail}. With #{body}"
  end
end
