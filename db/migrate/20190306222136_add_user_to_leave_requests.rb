class AddUserToLeaveRequests < ActiveRecord::Migration[5.0]
  def change
    add_reference :leave_requests, :patrons, foreign_key: true
  end
end
