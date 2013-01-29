ActiveAdmin.register Employement do

  menu :parent => "Settings", :if => proc{ current_user.role.name=="admin" }

  filter :employee, :as => :select, :collection => proc { Employee.all }
  filter :employer
  filter :date_of_joining
  filter :date_of_leaving
  filter :rating

  member_action :publish do
    @employement = Employement.find(params[:id])
    @employement.update_attribute(:is_published,1)
    #refresh
    redirect_to admin_my_employments_path , :notice => "Employment record was published !"
  end

  member_action :approve do
    @employement = Employement.find(params[:id])
    @employement.update_attribute(:status_id,Status.find_by_name("Approved").id)
    @employement.update_attribute(:approved_by,current_user.id)
    #refresh
    redirect_to admin_my_employments_path, :notice => "Employment record was approved !"
  end

  member_action :submit do
    @employement = Employement.find(params[:id])
    @employement.update_attribute(:status_id,Status.find_by_name("Submitted").id)
    #refresh
    redirect_to admin_my_employments_path, :notice => "Employment record was submitted !"
  end

  index do
    column "Employee" do |employement|
      employement.employee.name
    end

    column "Employer" do |employement|
      employement.employer.employer_code
    end

    column "Joining On" do |employement|
      employement.date_of_joining
    end

    column "Left On" do |employement|
      employement.date_of_leaving
    end

    column "Duration" do |employement|
      distance_of_time_in_words(employement.date_of_leaving, employement.date_of_joining)
    end

    column "Exit Comments", :exit_comments
    column "Rating", :rating

    if current_user.role.name == "admin"
    default_actions
    end
  end

  controller do
    def new
      @employement = Employement.new

      @employee = Employee.find(params[:employee])
      @employer = current_user.employer
      @employement.employee_id=@employee.id
      @employement.employer_id=@employer.id
    end
  end

  form :partial => "/employements/form"


end
