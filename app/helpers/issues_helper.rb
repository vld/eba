module IssuesHelper
  def string_state(state)
    case state
    when "wait_staff"
      "Waiting for Staff Response"
    when "wait_customer"
      "Waiting for Customer"
    when "on_hold"
      "On Hold"
    when "closed"
      "Completed"
    when "cancelled"
      "Cancelled"
    end
  end
end
