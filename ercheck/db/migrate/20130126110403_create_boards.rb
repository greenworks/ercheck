class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
