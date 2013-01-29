class CreateExternalMatterHistories < ActiveRecord::Migration
  def change
    create_table :external_matter_histories do |t|
      t.string :type

      t.timestamps
    end
  end
end
