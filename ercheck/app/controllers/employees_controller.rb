class EmployeesController < ApplicationController
  helper_method :sort_column, :sort_direction

  load_and_authorize_resource


  # GET /employees
  # GET /employees.json
  def index
   @employees = Employee.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employees }
    end
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @employee = Employee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
    end
  end

  # GET /employees/new
  # GET /employees/new.json
  def new
    @employee = Employee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee }
    end
  end

  # GET /employees/1/edit
  def edit
    @employee = Employee.find(params[:id])
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(params[:employee])

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render json: @employee, status: :created, location: @employee }
      else
        format.html { render action: "new" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /employees/1
  # PUT /employees/1.json
  def update
    @employee = Employee.find(params[:id])

    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end



  def import
    Employee.import(params[:file])
    redirect_to root_url, notice: "Employee records imported."
  end



  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to admin_my_employees_path }#format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end



  private
  def sort_column
    Employee.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end

=begin
   # GET /employees
   # GET /employees.json
  def import


    if request.post? && params[:file].present?
      infile = params[:file].read
      n, errs = 0, []
    end



    infile = 'C:\\DATA\\sample_employee.csv'
    n, errs = 0, []

    CSV.parse(infile) do |row|
      n += 1
      # SKIP: header i.e. first row OR blank row
      next if n == 1 or row.join.blank?
      # build_from_csv method will map customer attributes &
      # build new customer record
      employee = Employee.build_from_csv(row)
      # Save upon valid
      # otherwise collect error records to export
      if employee.valid?
        employee.save
      else
        errs << row
      end
    end

    # Export Error file for later upload upon correction
    if errs.any?
      errFile ="errors_#{Date.today.strftime('%d%b%y')}.csv"
      errs.insert(0, Employee.csv_header)
      errCSV = CSV.generate do |csv|
        errs.each {|row| csv << row}
      end
      send_data errCSV, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{errFile}.csv"
    else
      flash[:notice] = I18n.t('employee.import.success')
      redirect_to import_url #GET
    end

    @employees = Employee.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employees }
    end
  end
=end