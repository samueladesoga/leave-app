class SetLeaveRequestStatusDefaultFalse < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :leave_requests, :status, from: nil, to: false
  end
end
