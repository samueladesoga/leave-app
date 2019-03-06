class CreateLeaveRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_requests do |t|
      t.date :commence
      t.date :end
      t.text :reason
      t.boolean :status

      t.timestamps
    end
  end
end
