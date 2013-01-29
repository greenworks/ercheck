class CreateSeverances < ActiveRecord::Migration
  def change
    create_table :severances do |t|
      t.string :status

      t.timestamps
    end
  end
end
