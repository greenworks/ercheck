class CreateNoticePeriodServeds < ActiveRecord::Migration
  def change
    create_table :notice_period_serveds do |t|
      t.string :flag

      t.timestamps
    end
  end
end
