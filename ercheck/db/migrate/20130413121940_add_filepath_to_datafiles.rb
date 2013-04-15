class AddFilepathToDatafiles < ActiveRecord::Migration
  def change
    add_column :datafiles, :filepath, :string
  end
end
