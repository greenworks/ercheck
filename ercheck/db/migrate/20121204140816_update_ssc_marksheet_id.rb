class UpdateSscMarksheetId < ActiveRecord::Migration
  def up
    remove_column :employees, :ssc_marksheet_id
    add_column :employees, :ssc_marksheet_code, :string
  end

  def down
  end
end
