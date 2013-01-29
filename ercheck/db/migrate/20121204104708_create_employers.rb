class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :name
      t.string :employer_code
      t.text :address
      t.string :city

      t.timestamps
    end
  end
end
