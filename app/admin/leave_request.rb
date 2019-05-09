ActiveAdmin.register LeaveRequest do
  permit_params :approved, :commence, :end_date

  batch_action :approve do |ids|
    batch_action_collection.find(ids).each do |leave_request|
      leave_request.update_attributes(:approved => true)
    end
    redirect_to collection_path, alert: "The leave requests have been approved"
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
    column :approved
    actions
  end

  filter :patron_first_name_or_patron_last_name_cont, label: 'Name'
  filter :commence
  filter :end_date
  filter :reason
  filter :approved

end