class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name
      t.text :address

      t.timestamps
    end
  end
end
