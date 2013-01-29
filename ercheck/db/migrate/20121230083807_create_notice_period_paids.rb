class CreateNoticePeriodPaids < ActiveRecord::Migration
  def change
    create_table :notice_period_paids do |t|
      t.string :flag

      t.timestamps
    end
  end
end
