class CreateHistoryImpactCodeIds < ActiveRecord::Migration
  def change
    create_table :history_impact_code_ids do |t|
      t.string :code

      t.timestamps
    end
  end
end
