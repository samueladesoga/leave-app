class RenameEndToEndDateInLeaveRequests < ActiveRecord::Migration[5.0]
  def change
  	rename_column :leave_requests, :end, :end_date
  end
end
