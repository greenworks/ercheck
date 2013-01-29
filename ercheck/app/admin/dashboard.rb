ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }


  content :title => proc{ (current_user.role.name) + "  " + I18n.t("active_admin.dashboard")   } do

    h3 {current_user.role.name}
    #h3 current_user.role.name? "admin"

      panel "Search Employee" do
      div do
        render "employees/search"
      end
    end

    br
    panel "Recently Created Employees records"  do
      table_for Employee.where("created_by = (?) OR (?) ",current_user, current_user.role.name=="admin" ).order("created_at desc").limit(5) do
        column :name do |employee|
          link_to employee.name, [:admin, employee]
        end
        column "PAN", :pancard
        column "Date of Birth" , :date_of_birth
        column "Employment Records" do |employee|
          employee.employements.size
        end

        column "Record Status" do |employee|
          employee.status && employee.status.name
        end

      end
      strong { link_to "View All Employees", admin_my_employees_path }
    end

    br

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
