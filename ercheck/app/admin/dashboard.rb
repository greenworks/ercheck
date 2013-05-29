ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{   I18n.t("active_admin.dashboard")  + " for "  + (current_user.role.name).capitalize  + " of " + (current_user.employer.name)} do


    if current_user.role && current_user.role.name == "user"

      panel "Recently Created Employees records"  do
        table_for Employee.where("created_by = ? ",current_user ).order("created_at desc").limit(5) do
          column :name do |employee|
            link_to employee.name, [:admin, employee]
          end
          column "PAN", :pancard
          column "Date of Birth" , :date_of_birth
          column "Employment Records" do |employee|
            employee.employements.size
          end

          column "Board", :board

          column "Marksheet", :ssc_marksheet_code

          column "Created By" do |employee|
            User.find(employee.created_by).name
          end

          column "Record Status" do |employee|
            #employee.status && employee.status.name
            @employement = Employement.where(" employee_id = ? and employer_id = ?", employee, current_user.employer_id)
            @employement.first && @employement.first.status && @employement.first.status.name

          end

        end
        strong { link_to "View All Employees created by you", admin_all_employees_path }

        br

        strong {link_to 'Add New Employee', new_admin_employee_path}
      end

    end

   if current_user.role && current_user.role.name == "manager"


     panel "User wise summary for employment records"   do
       table_for Employement.search_accessible_employments(current_user).all(:select  => "created_by , status_id , count(id) as records", :group => "created_by, status_id" ) do \
       #:having => ( " created_by in #{user_list }") ) do
#         table_for Employement.all(:select  => "created_by , status_id , count(id) as records", :group => "created_by, status_id" , :having => ( @employement.created_by.in?User.search_reporting_users(current_user.id).collect(&:id) ) ) do

         column "User" do |employement|
           User.find(employement.created_by).name
         end

         column "Activity Count" do |employement|
            pluralize(employement.records, "record")
         end

         column "Status" do |employement|
           employement.status && employement.status.name
         end


       end

       strong { link_to "Search Employee", "/admin/search_employee" }

       br

       strong { link_to "View All Employees created by team", admin_all_employees_path }

     end

   end


   if current_user.role && (current_user.role.name == "admin" || curent_user.email == "user@widewindow.com" )

     panel "Employer wise summary"   do
       table_for Employer.all do
         column :name
         column "Created" do |employer|
            Employement.search_by_status(1).where("employer_id = ? ", employer.id).count
         end
         column "Submitted" do |employer|
           Employement.search_by_status(2).where("employer_id = ? ", employer.id).count
         end
         column "Rejected" do |employer|
           Employement.search_by_status(4).where("employer_id = ? ", employer.id).count
         end
         column "Approved" do |employer|
           Employement.search_by_status(3).where("employer_id = ? ", employer.id).count
         end
         column "Total" do |employer|
           Employement.where("employer_id = ? ", employer.id).count
         end
       end
     end

     panel "Recent Enquiries"  do
       table_for Enquiry.order("created_at desc").limit(5) do

         column :name do |enquiry|
           link_to enquiry.name, [:admin, enquiry]
         end
         column :email
         column :phone
         column :company_name
         column :name do |enquiry|
           enquiry.message
         end
       end

       strong { link_to "Total " +  pluralize(Enquiry.count, "enquiry") + " received" , admin_enquiries_path }

     end

     panel "Data upload" do
       div do
         link_to "Import employees from CSV ", new_employee_import_path
       end
     end

   end



    panel "Password Management" do
      div do
        link_to "Change Password",   edit_admin_user_path(current_user)
      end
    end

=begin
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span "Welcome to Active Admin. This is the default dashboard page."
        small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
      end
    end
=end



  end

end
