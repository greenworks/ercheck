ActiveAdmin.register Employee do
  config.clear_action_items!

  menu :parent => "Masters", :if => proc{ current_user.role.name=="admin" }

  #scope_to :current_user , :association_method => :creator

  filter :name
  filter :pancard
  filter :date_of_birth
  filter :university_id
  filter :ssc_marksheet_code
  filter :board

  member_action :publish do
    @employee = Employee.find(params[:id])
    @employee.update_attribute(:is_published,1)
    #refresh
    redirect_to admin_all_employees_path , :notice => "Employee record was published !"
  end

  member_action :approve do
    @employee = Employee.find(params[:id])
    @employee.update_attribute(:status_id,Status.find_by_name("Approved").id)
    @employee.update_attribute(:approved_by,current_user.id)
    #refresh
    redirect_to admin_all_employees_path, :notice => "Employee record was approved !"
  end

  member_action :submit do
    @employee = Employee.find(params[:id])
    @employee.update_attribute(:status_id,Status.find_by_name("Submitted").id)
    #refresh
    redirect_to admin_all_employees_path, :notice => "Employee record was submitted !"
  end

  member_action :create_employment do
    @employee = Employee.find(params[:id])
    @employee.update_attribute(:status_id,Status.find_by_name("Submitted").id)
    #refresh
    redirect_to admin_all_employees_path, :notice => "Employment record was created!"
  end

  action_item :only => :show do
    link_to '<< My Employees',admin_all_employees_path
  end

  action_item :only => :show do
    @employee = Employee.find(employee)
    if @employee.employements.count == 0 && current_user.role.name != "manager"
      link_to 'Edit Employee', [:edit, :admin, employee]
    else
      nil
    end
  end

  action_item :only => :show do
    if current_user.role.name != "manager"
      link_to 'Add Employee', new_admin_employee_path
    else
      nil
    end
  end



  action_item :only => :show do
    if current_user.role.name != "manager"
      link_to 'Create Employment Record', new_admin_employement_path(:employee => employee)
    else
      nil
    end
  end

#delete option not needed at all in system
=begin
  action_item :only => :show do
    link_to 'Delete Employee', employee, :confirm => 'Are you sure?', :method => :delete
  end
=end

  controller do
    def new
      if params[:pancard]
        @employee = Employee.find_or_create_by_pancard(params[:pancard]) # search_by_pancard(params[:pancard])
        if @employee.employements && @employee.employements.count >= 1 && @employee.employements.first.status.name != "Created"
          redirect_to admin_employee_path(@employee) , :notice => "Employment records exists for Employee with this PAN!"
        end
      elsif params.nil?
        @employee=Employee.new
          redirect_to self , :notice => "Employee with this PAN not found! Create New."
      end
    end
  end

=begin
  action_item :only => :show do
    #admin/employements/new?employee=32
    #link_to 'Create Employment Record 2', new_admin_employement_path, :employee_id => employee_id
    #link_to('employements',"/employements/new?id=" & employee.id )
  end
=end


  index do
    selectable_column
    column :id
    column :name
    column "PAN", :pancard
    column "Date of Birth" , :date_of_birth

    column "University"  do |employee|
      employee.university && employee.university.name
    end

    column "Employements" do |employee|
      employee.employements.size
    end

    column "SSC Code", :ssc_marksheet_code

      if current_user.role.name == "manager"
      column "Status" do |employee|
        if employee.status
          employee.status.name
        end
      end

      column "Created By" do|employee|
        if employee.creator
          employee.creator.name
        end
      end
    end

    if current_user.role.name == "admin"
        column "Status" do |employee|
          if employee.status
             employee.status.name
          end
        end

        column "Created By" do|employee|
          if employee.creator
            employee.creator.name
          end
        end

        column "Approved By" do|employee|
          if employee.approver
            employee.approver.name
          end
        end
        #default actions of edit and delete are with admin only
    end

    if current_user.role.name == "admin"
      default_actions
    end
  end

  show do |employee|
    attributes_table do
      row :name
      row :surname
      row "Employment(s)" do |employee|
        render "/employements/employement", :employements=> employee.employements
      end
      row :mother_name
      row :father_name
      row :date_of_birth
      row :pancard
      row :metric_passing_year
      row "SSC Board" do |employee|
        employee.board && employee.board.name
      end
      row :ssc_marksheet_code

      row :highest_qualification do |employee|
        employee.highest_qualification && employee.highest_qualification.name
      end
      row :highest_qualification_passing_year
      row "University" do |employee|
        employee.university && employee.university.name
      end
      row :mobile
      row :res_landline


      if current_user.role.name == "manager"
        row :creator
        row :approver
        row :created_at
        row :updated_at
      end

      if current_user.role.name == "admin"
        row :status_id
        row :is_published
        row :creator
        row :approver
        row :created_at
        row :updated_at
      end

      row "Status" do |employee|
        employee.status && employee.status.name
      end

      row :is_published
    end
  end

  form :partial => "/employees/form"

=begin
    controller do
      #This code is evaluated within the controller class

      def scoped_collection
      if current_user.role.name == "admin"
          Employee.search_all()
      else
        if current_user.role.name == "manager"
            Employee.search_by_creator(1)
       end
      end
        end
    end
=end

end
