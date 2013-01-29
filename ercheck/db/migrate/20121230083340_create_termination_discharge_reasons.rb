class CreateTerminationDischargeReasons < ActiveRecord::Migration
  def change
    create_table :termination_discharge_reasons do |t|
      t.string :code

      t.timestamps
    end
  end
end
