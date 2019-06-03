class RemoveApprovedFromLeaveRequests < ActiveRecord::Migration[5.0]
  def change
    remove_column :leave_requests, :approved, :boolean
  end
end
