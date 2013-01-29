ActiveAdmin.register_page "Search Employee" do
  menu :parent => "Search", :priority => 1
  content do
        render :partial => "/employees/search"
  end
end

