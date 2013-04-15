class EmployeeImportsController < ApplicationController
  def new
    @employee_import = EmployeeImport.new
  end

  def create
    @employee_import= EmployeeImport.new(params[:employee_import])
    if @employee_import.save
      redirect_to admin_employees_path, notice: "Imported Employee records successfully."
    else
      render :new
    end
  end
end
