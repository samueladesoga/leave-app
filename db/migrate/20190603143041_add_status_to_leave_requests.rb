class AddStatusToLeaveRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :leave_requests, :status, :integer, default: 0
  end
end
