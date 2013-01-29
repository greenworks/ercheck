class AddMultipleColumnsToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :surname, :string
    add_column :employees, :mother_name, :string
    add_column :employees, :father_name, :string
    add_column :employees, :string, :string
    add_column :employees, :metric_passing_year, :integer
    add_column :employees, :Board_id, :integer
    add_column :employees, :highest_qualification, :string
    add_column :employees, :highest_qualification_passing_year, :string
    add_column :employees, :mobile, :integer
    add_column :employees, :res_landline, :string
  end
end
