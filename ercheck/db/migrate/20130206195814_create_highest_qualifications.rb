class CreateHighestQualifications < ActiveRecord::Migration
  def change
    create_table :highest_qualifications do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
