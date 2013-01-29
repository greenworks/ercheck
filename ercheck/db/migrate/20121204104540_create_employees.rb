class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :pancard
      t.date :date_of_birth
      t.string :ssc_marksheet_id
      t.integer :university_id

      t.timestamps
    end
  end
end
