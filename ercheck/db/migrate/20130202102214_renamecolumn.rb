class Renamecolumn < ActiveRecord::Migration
  def change
    rename_column :employees, :Board_id, :board_id
  end
end
