ActiveAdmin.register User do
  menu :parent => "Masters", :if => proc{ current_user.role.name=="admin" }

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
      f.input :email
      f.input :employer
      f.input :role
      f.input :manager
      f.input :password
    end
    f.buttons
  end

end
