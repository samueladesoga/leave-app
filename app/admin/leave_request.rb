ActiveAdmin.register LeaveRequest do
  permit_params :status

  index do
    selectable_column
    id_column
    column :name
    column :commence
    column :end_date
    column :reason
    column :status
    actions
  end

  filter :name
  filter :commence
  filter :end
  filter :reason
  filter :status

end
