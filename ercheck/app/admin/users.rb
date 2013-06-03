ActiveAdmin.register User do

  menu :parent => "Masters", :if => proc{ current_user.role.name=="admin" }

  config.clear_action_items!

  action_item :only => :show do
    link_to('Edit User', edit_admin_user_path(current_user)) if  (current_user.role.name=="admin")
  end

  def remote_request(type, path, params={}, target_tag_id)
    "$.#{type}('#{path}',
             {#{params.collect { |p| "#{p[0]}: #{p[1]}" }.join(", ")}},
             function(data) {$('##{target_tag_id}').html(data);}
   );"
  end

=begin
    action_item :only => :show  do
      puts "current_user.role.name -> #{current_user.role.name}"
    if current_user.role.name=="admin"
      link_to "New User", "/admin/users/new"
    else
      link_to "Password", "/admin/users/edit"
    end
  end
=end


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
    if current_user.role.name=="admin"
      default_actions
    else
      actions :edit
    end
  end


  show do |user|
    attributes_table do
      row :id
      row :name
      row :email
      row "Employer" do |user|
        user.employer && user.employer.name
      end
      row "Role" do |user|
        user.role && user.role.name
      end
      row "manager" do |user|
        user.manager && user.manager.name
      end
    end
=begin
    if current_user.role.name=="admin"

      Current Sign In At 	May 29, 2013 12:31
      Last Sign In At 	May 29, 2013 12:29
      Current Sign In Ip 	127.0.0.1
      Last Sign In Ip 	127.0.0.1
      Created At 	May 29, 2013 11:44
      Updated At 	May 29, 2013 12:31
      default_actions
    else
      actions :edit
    end
=end

  end

  form do |f|
    puts "current_user.role.name -> #{current_user.role.name}"

    f.inputs "Details" do
      f.input :name
      if current_user.role.name=="admin"
          f.input :email
          f.input :employer, :input_html => {
              :onchange => remote_request(:post, :change_managers, {:employer_id=>"$('#user_employer_id').val()"}, :manager_id)
          }
          @employer = User.find(params[:id]).employer_id
          f.input :manager, :label => "manager", :as => :select, :collection => User.search_manager_by_employer_id(@employer)
          #f.input :manager
          f.input :role
      end
      f.input :password
      f.input :password_confirmation
    end
    f.actions

  end


  controller do
    def change_managers
     @managers = User.search_manager_by_employer_id(params[:employer_id])#.try(:users)

     render :text=>view_context.options_from_collection_for_select(@managers, :id, :name)
     #render :text=>view_context.collection_select("manager",nil, User.search_manager_by_employer_id(params[:employer_id]), :id, :name)
     #collection_select  "board",nil, @boards, :id, :name, {:prompt => true}

    end
  end

    #form :partial => "/devise/registrations/edit_user"
end
