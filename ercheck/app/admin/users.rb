ActiveAdmin.register User do

  menu :parent => "Masters", :if => proc{ current_user.role.name=="admin" }


  action_item :only => :show  do
    if current_user.role.name=="admin"
      link_to "New User", "/admin/users/new"
    else
      link_to "Password", "/admin/users/edit"
    end
  end


=begin
  member_action :reset_password do
    @user = User.find(params[:id])
    @user.update_attribute(:password,"password")
    redirect_to admin_users_path , :notice => "password was reset!"
  end

  action_item :only => :show   do
    link_to admin_users_path , :notice => "password was reset!"
  end
=end


  index do
    selectable_column
    column :id
    column :name
    column :email
    column :employer
    column :role
    column :manager
  default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      if current_user.role.name=="admin"

            f.input :email

          f.input :employer
          f.input :role
          f.input :manager
        end
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end

end
