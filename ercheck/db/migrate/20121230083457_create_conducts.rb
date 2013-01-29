class CreateConducts < ActiveRecord::Migration
  def change
    create_table :conducts do |t|
      t.string :type

      t.timestamps
    end
  end
end
