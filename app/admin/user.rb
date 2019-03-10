ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name

  controller do
    def create
      @user = User.invite!(permitted_params[:user], current_admin)
      if @user.new_record?
        render action: 'new'
      else
        redirect_to resource_path(@user), notice: 'User invited successfully!'
      end
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :invited_by
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :invited_by_id, :as => :select, :collection => proc { Admin.all.collect{|admin| [admin.email, admin.id]}}

  form do |f|
    f.inputs "Invite User #{current_admin.inspect}" do
      f.input :email
      f.input :first_name
      f.input :last_name
    end
    f.actions
  end

end
