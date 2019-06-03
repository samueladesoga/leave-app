ActiveAdmin.register LeaveRequest do
  permit_params :status, :commence, :end_date, :patron_id, :reason

  batch_action :approve do |ids|
    batch_action_collection.find(ids).each do |leave_request|
      leave_request.approve!
    end
    redirect_to collection_path, alert: "The leave requests have been approved"
  end

  batch_action :reject do |ids|
    batch_action_collection.find(ids).each do |leave_request|
      leave_request.reject!
    end
    redirect_to collection_path, alert: "The leave requests have been rejected"
  end

  index do
    selectable_column
    id_column
    column :name, :sortable => :id do |leave_request|
       leave_request.patron.full_name
    end
    column :commence
    column :end_date
    column :reason
    column :status
    actions
  end

  filter :patron_first_name_or_patron_last_name_cont, label: 'Name'
  filter :commence
  filter :end_date
  filter :reason
  filter :status, as: :select, collection: LeaveRequest.statuses

end