ActiveAdmin.register Employement do

  menu :parent => "Masters", :if => proc{ current_user.role.name=="admin" }

  filter :employee, :as => :select, :collection => proc { Employee.all }
  filter :employer
  filter :date_of_joining
  filter :date_of_leaving
  filter :rating
  filter :creator

  config.clear_action_items!


  action_item :only => :show do
    @employement= Employement.find(employement)
    if @employement.status == "Created"
      link_to 'Edit Employement',edit_admin_employement_path(:employement=> employement)
    else
      link_to '<< My Employees',admin_all_employees_path

    end
  end


  action_item :only => :show do
    @employement= Employement.find(employement)
    @employee = @employement.employee

    link_to '<< Employee Personal details', admin_employee_path(@employement.employee)

  end

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


  member_action :reject do
    @employement = Employement.find(params[:id])
    @employement.update_attribute(:status_id,Status.find_by_name("Rejected").id)
    @employement.update_attribute(:approved_by,current_user.id)
    #refresh
    redirect_to admin_my_employments_path, :notice => "Employment record was rejected !"
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

=begin
    if current_user.role.name == "admin"
      default_actions
    end
=end
  end

  show do |employement|
    attributes_table do
          row :employee
          row "Employer(s)" do |employement|
            employement.employer && employement.employer.name
          end
          row :date_of_joining
          row :resignation_date
          row :date_of_leaving

          row :exit_comments

          row :employee_code
          row "designation" do |employement|
            employement.designation && employement.designation.name
          end

          row "function" do |employement|
            employement.department && employement.department.name
          end

          row "function" do |employement|
            employement.designation && employement.designation.name
          end

          row :recorded_address
          row :mobile
          row :landline

          row "highest_qualification" do |employement|
            employement.highest_qualification && employement.highest_qualification.name
          end

          row :highest_qualification_year

          row :last_pms_performance_rating
          row :previous_pms_year_performance_rating

          row :before_previous_pms_year_performance_rating
          row :ctc_on_hire
          row :ctc_on_severance

          row "severance" do |employement|
            employement.severance && employement.severance.name
          end
          row "reason" do |employement|
            employement.reason && employement.reason.name
          end
          row :other_reason

          row "reason" do |employement|
            employement.reason && employement.reason.name
          end

          row "termination_discharge_reason" do |employement|
            employement.termination_discharge_reason && employement.termination_discharge_reason.name
          end
          row :other_termination_discharge_reason

          row :regret_flag

          row "rehire_flag" do |employement|
            employement.rehire_flag && employement.rehire_flag.name
          end

          row "conduct" do |employement|
            employement.conduct && employement.conduct.name
          end

          row "external_matter_history" do |employement|
            employement.external_matter_history && employement.external_matter_history.name
          end

          row "history_impact" do |employement|
            employement.history_impact && employement.history_impact.name
          end

          row "category" do |employement|
            employement.category && employement.category.name
          end



          row "notice_period_served" do |employement|
            employement.notice_period_served && employement.notice_period_served.name
          end

          row "notice_period_paid" do |employement|
            employement.notice_period_paid && employement.notice_period_paid.name
          end

          row "full_n_final_status" do |employement|
            employement.full_n_final_status && employement.full_n_final_status.name
          end

          row "settlement_pending_side" do |employement|
            employement.settlement_pending_side && employement.settlement_pending_side.name
          end

          row "Status" do |employement|
            employement.status && employement.status.name
          end

          if current_user.role.name == "manager" ||  current_user.role.name == "admin"
            row "creator" do |employement|
              employement.creator && employement.creator.name
            end

            row "approver" do |employement|
              employement.approver && employement.approver.name
            end


            row :created_at
            row :updated_at
          end

          if current_user.role.name == "admin"
            row "Status" do |employement|
              employement.status && employement.status.name
            end

            row :is_published
            row "creator" do |employement|
              employement.creator && employement.creator.name
            end

            row "approver" do |employement|
              employement.approver && employement.approver.name
            end
            row :created_at
            row :updated_at
          end

          row :is_published

=begin
          if current_user.role.name == "admin"
            action :edit
          end
=end
    end


  end

  controller do
    def new
      @employement = Employement.new

      @employee = Employee.find(params[:employee])
      @employer = current_user.employer
      @employement.employee_id=@employee.id
      @employement.employer_id=@employer.id
      @employement.status_id=Status.find_by_name("Created").id

    end
  end

  form :partial => "/employements/form"


end
