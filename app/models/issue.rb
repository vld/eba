class Issue < ActiveRecord::Base
  belongs_to :manager
  attr_accessible :body, :code, :customer_email, :customer_name, :department, :state, :subject

  after_create :generate_code

  def generate_code
    self.code = "ABC-" << "%05d" % self.id.to_s
    self.save
  end

  state_machine :initial => :wait_staff do
    event 'hold' do
      transition :wait_staff => :on_hold
    end
    event 'sent_to_customer' do
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
  end
end

#ʻWaiting for Staff Responseʼ, ʻWaiting for Customerʼ, ʻOn Holdʼ, ʻCancelledʼ or ʻCompletedʼ