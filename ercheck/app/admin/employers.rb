ActiveAdmin.register Employer do

  menu :parent => "Masters", :if => proc{ current_user.role.name=="admin" }

  index do
    column "Name" , :name

    column "Employer Code" , :employer_code

    column "Address", :address

    column "City", :city

    column "Industry", :industry

    column "Employees" do |employer|
      employer.employements.count
    end

    default_actions
  end


end
