class CreateDatafiles < ActiveRecord::Migration
  def change
    create_table :datafiles do |t|
      t.string :name
      t.string :records
      t.string :status

      t.timestamps
    end
  end
end
