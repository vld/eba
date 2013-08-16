# encoding: UTF-8
class CustomerMailer < ActionMailer::Base
  default from: "postman@eba.com"

  def issue_created_email(issue)
    @issue = issue
    @name = @issue.customer_name
    @email = @issue.customer_email
    mail(to: @email, subject: "Created new issue #{@issue.code}")
  end

  def commented_email(issue)
    @issue = issue
    @name = @issue.customer_name
    @email = @issue.customer_email
    mail(to: @email, subject: "New comment on #{@issue.code}")
  end

end