class SetLeaveDefaultToNil < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :leave_requests, :approved, from: false, to: nil
  end
end
