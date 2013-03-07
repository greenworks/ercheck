class AddColumnsToEmployment < ActiveRecord::Migration
  def change
    add_column :employements, :mobile, :intger
    add_column :employements, :landline, :integer
    add_column :employements, :highest_qualification_id, :integer
    add_column :employements, :highest_qualification_year, :integer
  end
end
