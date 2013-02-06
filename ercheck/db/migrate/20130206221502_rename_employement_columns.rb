class RenameEmployementColumns < ActiveRecord::Migration
  def change
    rename_column :employements, :designation, :designation_id
    rename_column :employements, :department, :department_id
    rename_column :employements, :function, :function_id
    rename_column :employees, :highest_qualification, :highest_qualification_id
  end
end
