ActiveAdmin.register_page "My Employees" do

  menu :parent => "My Account", :priority => 5

  #scope :published

  content do
     render "/employees/employees"
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