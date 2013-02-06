ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }


  content :title => proc{   I18n.t("active_admin.dashboard")  + " for " + (current_user.role.name).capitalize  } do

   render "employees/search"

    br

    #if current_user.role && current_user.role.name == "user"

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
        strong { link_to "View All Employees created by you", admin_my_employees_path }
      end

    #end
    br

=begin
    panel "Recently Created Employments records"  do
      table_for Employement.order("created_at desc").where(:created_by => current_user).limit(5) do

        column "Employee" do |employement|
          link_to employement.employee.name, [:admin, employement ]
        end
        column "Employer" do |employement|
          employement.employer.employer_code
        end
        column "Joining On" , :date_of_joining
        column "Left On" , :date_of_leaving
        column "Duration" do |employement|
          distance_of_time_in_words(employement.date_of_leaving, employement.date_of_joining)
        end
        column "Exit Comments", :exit_comments
        column "Rating", :rating
      end
      strong { link_to "View All Employments", admin_my_employments_path }
    end
=end

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
