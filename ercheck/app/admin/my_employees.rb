ActiveAdmin.register_page "All Employees" do


  menu :parent => "Employee Records", :if => proc{ current_user.role.name!="admin" }

  #scope :published

  content do
    params[:status]="All"
    #render "/employees/employees"
    render "/employements/index"

  end

  action_item do
    link_to "New Employee", "/admin/employees/new"
  end

=begin
  action_item do
    link_to "Data Loader", "/admin/data_loader"
  end
=end


=begin
  action_item  do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "admin/csv/upload_csv"
  end

  collection_action :import_csv, :method => :post do
    UniversityCsvDb.convert_save("post", params[:dump][:file])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end
=end

end