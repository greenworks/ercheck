class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :severances, :status, :name
    rename_column :reasons, :code, :name
    rename_column :termination_discharge_reasons, :code, :name
    rename_column :rehire_flags, :value, :name
    rename_column :conducts, :type, :name
    rename_column :external_matter_histories, :type, :name
    rename_column :history_impact_code_ids, :code, :name
    rename_column :categories, :color, :name
    rename_column :notice_period_serveds, :flag, :name
    rename_column :notice_period_paids, :flag, :name
    rename_column :full_n_final_statuses, :type, :name
    rename_column :settlement_pending_sides, :account, :name
  end
end
