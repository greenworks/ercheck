class CreateFullNFinalStatuses < ActiveRecord::Migration
  def change
    create_table :full_n_final_statuses do |t|
      t.string :type

      t.timestamps
    end
  end
end
