ActiveAdmin.register User do

  menu :parent => "Masters", :if => proc{ current_user.role.name=="admin" }

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

  form do |f|
    puts "current_user.role.name -> #{current_user.role.name}"

    f.inputs "Details" do
      f.input :name
      if current_user.role.name=="admin"
          f.input :email
          f.input :employer
=begin
          f.input :employer, :input_html => {
              :onchange => remote_request(:post, :change_managers, {:employer_id=>"$('#user_employer_id').val()"}, :manager)
          }
=end
          f.input :manager
          f.input :role
      end
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end


  controller do
    def change_managers
      @managers = User.find_by_employer_id(params[:employer_id]).try(:manager)
      render :text=>view_context.options_from_collection_for_select(@managers, :id, :manager_id)
    end
  end


    #form :partial => "/devise/registrations/edit_user"

end
