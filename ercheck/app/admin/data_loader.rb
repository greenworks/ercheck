ActiveAdmin.register_page "Data Loader" do

  menu false
  content do

    render "/common/data_loader"#, :f => builder
=begin
    form do |f|

      f.file_field :csv_file , :as => :file
    end
=end

  end
end

