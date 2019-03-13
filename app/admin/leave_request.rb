ActiveAdmin.register LeaveRequest do
  permit_params :approved, :commence, :end_date

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
  filter :end_date
  filter :reason
  filter :approved

end