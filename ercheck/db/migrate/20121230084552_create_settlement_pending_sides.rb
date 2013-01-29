class CreateSettlementPendingSides < ActiveRecord::Migration
  def change
    create_table :settlement_pending_sides do |t|
      t.string :account

      t.timestamps
    end
  end
end
