class RenameStatusToApprovedInLeaveRequest < ActiveRecord::Migration[5.0]
  def change
  	rename_column :leave_requests, :status, :approved
  end
end
