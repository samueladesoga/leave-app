ActiveAdmin.register LeaveRequest do
  permit_params :status

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

  filter :name
  filter :commence
  filter :end
  filter :reason
  filter :approved

end