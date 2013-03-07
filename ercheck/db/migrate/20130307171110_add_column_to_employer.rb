class AddColumnToEmployer < ActiveRecord::Migration
  def change
    add_column :employers, :industry_id, :integer
  end
end
