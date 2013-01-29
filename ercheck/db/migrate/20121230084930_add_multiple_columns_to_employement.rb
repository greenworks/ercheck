class AddMultipleColumnsToEmployement < ActiveRecord::Migration
  def change
    add_column :employements, :employee_code, :string
    add_column :employements, :resignation_date, :date
    add_column :employements, :designation, :string
    add_column :employements, :department, :string
    add_column :employements, :function, :string
    add_column :employements, :recorded_address, :string
    add_column :employements, :severance_id, :integer
    add_column :employements, :reason_id, :integer
    add_column :employements, :other_reason, :text
    add_column :employements, :discharge_termination_reason_id, :integer
    add_column :employements, :other_discharge_termination_reason, :text
    add_column :employements, :regret_flag, :boolean
    add_column :employements, :rehire_flag_id, :integer
    add_column :employements, :conduct_id, :integer
    add_column :employements, :external_matter_history_id, :integer
    add_column :employements, :history_impact_id, :integer
    add_column :employements, :category_id, :integer
    add_column :employements, :last_pms_performance_rating, :integer
    add_column :employements, :previous_pms_year_performance_rating, :integer
    add_column :employements, :before_previous_pms_year_performance_rating, :integer
    add_column :employements, :ctc_on_hire, :decimal
    add_column :employements, :ctc_on_severance, :decimal
    add_column :employements, :notice_period_served_id, :integer
    add_column :employements, :notice_period_paid_id, :integer
    add_column :employements, :full_n_final_status_id, :integer
    add_column :employements, :settlement_pending_side_id, :integer
  end
end
