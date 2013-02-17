ActiveAdmin.register_page "Search Employee" do

  #menu :parent => "Search", :priority => 1

  content do


        render :partial => "/employees/search"


        if params[:pancard]
          @employee = Employee.search_by_pancard(params[:pancard])

          if @employee.nil?
            h4 "No employee found"
          else
            panel "Employees records"  do
              table_for Employee.search_by_pancard(params[:pancard]) do
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
              strong { link_to "View All Employees", admin_all_employees_path }
            end
          end

        elsif params[:ssc_marksheet_code]
          @employee = Employee.search_by_marksheet(params[:ssc_marksheet_code],1,params[:metric_passing_year])

          if @employee.nil?
            h4 "No employee found"
          else
            panel "Employees records"  do
              table_for Employee.search_by_marksheet(params[:ssc_marksheet_code],1,params[:metric_passing_year]) do
                column :name do |employee|
                  link_to employee.name, [:admin, employee]
                end
                column :metric_passing_year
                column :board do |employee|
                  employee.board && employee.board.name
                end
                column :ssc_marksheet_code
                column "Date of Birth" , :date_of_birth
                column "Employment Records" do |employee|
                  employee.employements.size
                end

                column "Record Status" do |employee|
                  employee.status && employee.status.name
                end

              end
              strong { link_to "View All Employees", admin_all_employees_path }
            end
          end

        end




  end

 # @employee = Employee.search_by_pancard(params[:pancard],params[:marksheet])


end

