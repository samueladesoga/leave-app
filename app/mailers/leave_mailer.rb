class LeaveMailer < ApplicationMailer
  def notify_user(user_id, leave_id)
    user = Patron.find(user_id)
    leave_request = LeaveRequest.find(leave_id)
    @status = leave_request.status
    mail(:to => @order.user.email,
         :subject => "Your Leave Request has been updated")  
  end
end