class Issue < ActiveRecord::Base
  belongs_to :manager
  attr_accessible :body, :code, :customer_email, :customer_name, :department, :state, :subject

  after_create :generate_code

  def generate_code
    code = "ABC-" << id.to_s
  end
end
