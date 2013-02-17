ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{   I18n.t("active_admin.dashboard")  + " for "  + (current_user.role.name).capitalize  + " of " + (current_user.employer.name)} do

   #render "employees/search"

    br

    if current_user.role && current_user.role.name == "user"

=begin
      action_item do
      end
=end

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
            employee.status && employee.status.name
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


   if current_user.role && current_user.role.name == "admin"
     panel "Employer wise summary"   do
      table_for Employement.all(:select  => "employer_id, count(employee_id) as employees", :group => "employer_id ") do
        column :employer
        column :employees
      end
     end
     strong { link_to "View All Employments", admin_all_employees_path }
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

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
    # content

end
