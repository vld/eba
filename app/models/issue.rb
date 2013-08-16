class Issue < ActiveRecord::Base
  include IssuesHelper
  belongs_to :manager
  attr_accessible :body, :code, :customer_email, :customer_name, :department, :state, :subject, :delta

  after_create :generate_code, :send_mail
  scope :closed, where(state: [:completed, :cancelled])
  scope :unassigned, where(manager_id: nil)
  has_many :comments

  def generate_code
    self.code = "ABC-" << "%05d" % self.id.to_s
    self.save
  end

  def send_mail
    CustomerMailer.issue_created_email(self).deliver
  end

  state_machine :initial => :wait_staff do
    event 'hold' do
      transition :wait_staff => :on_hold
    end
    event 'send_to_customer' do
      transition :on_hold => :wait_customer
    end
    event 'customer_update' do
      transition :wait_customer => :wait_staff
    end
    event 'complete' do
      transition :on_hold => :completed
    end
    event 'cancel' do
      transition :on_hold => :cancelled
    end

    after_transition do |issue, transition|
      issue.comments.create(body: "State was changed: #{issue.string_state(transition.from)} -> #{issue.string_state(transition.to)}")
    end
  end
end

#ʻWaiting for Staff Responseʼ, ʻWaiting for Customerʼ, ʻOn Holdʼ, ʻCancelledʼ or ʻCompletedʼ