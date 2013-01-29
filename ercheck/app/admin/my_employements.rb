ActiveAdmin.register_page "My Employments" do

  menu :parent => "My Account", :priority => 5

  content do
    render "/employements/index"
  end

=begin
  action_item do
    link_to "New Employment", "/admin/employements/new"
  end
=end
end