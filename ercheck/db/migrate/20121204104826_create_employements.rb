class CreateEmployements < ActiveRecord::Migration
  def change
    create_table :employements do |t|
      t.integer :employee_id
      t.integer :employer_id
      t.date :date_of_joining
      t.date :date_of_leaving
      t.text :exit_comments
      t.integer :rating

      t.timestamps
    end
  end
end
