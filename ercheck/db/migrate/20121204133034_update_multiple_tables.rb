class UpdateMultipleTables < ActiveRecord::Migration
  def up
    add_column    :employees, :created_by,  :integer
    add_column    :employees, :approved_by,  :integer
    add_column    :employees, :is_published,  :integer
    add_column    :employees, :status_id,  :integer

    add_column    :employements, :created_by,  :integer
    add_column    :employements, :approved_by,  :integer
    add_column    :employements, :is_published,  :integer
    add_column    :employements, :status_id,  :integer

  end

  def down
  end
end
