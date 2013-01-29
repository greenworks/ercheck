class Employement < ActiveRecord::Base
  belongs_to :employee #, :foreign_key => "employee_id"
  belongs_to :employer #, :foreign_key => "employer_id"
  belongs_to :status
  belongs_to :severance
  belongs_to :history_impact
  belongs_to :reason
  belongs_to :external_matter_history
  belongs_to :history_impact
  belongs_to  :category
  belongs_to  :notice_period_served
  belongs_to  :notice_period_paid
  belongs_to  :full_n_final_status
  belongs_to  :settlement_pending_side
  belongs_to  :rehire_flag
  belongs_to :termination_discharge_reason
  belongs_to :conduct


  belongs_to :approver, :class_name => "User",   :foreign_key => "approved_by"
  belongs_to :creator,  :class_name => "User",   :foreign_key => "created_by"

  attr_accessible :employer_attributes, :employees_attributes, :employee_id, :employer_id, :date_of_joining, :date_of_leaving , :exit_comments, :rating, :status_id, \
  :created_by, :approved_by, :is_published, :employee_code, :resignation_date, :designation, :department, :function, \
  :recorded_address, :severance_id, :reason_id, :other_reason, :termination_discharge_reason_id, \
  :other_termination_discharge_reason, :regret_flag, :rehire_flag_id, :conduct_id, :external_matter_history_id, \
  :history_impact_id, :category_id, :last_pms_performance_rating, :previous_pms_year_performance_rating, \
  :before_previous_pms_year_performance_rating, :ctc_on_hire, :ctc_on_severance, :notice_period_served_id, \
  :notice_period_paid_id, :full_n_final_status_id, :settlement_pending_side_id

  validates_presence_of  :date_of_joining, :date_of_leaving, :exit_comments, :rating, \
  :severance_id, :reason_id, :regret_flag, :rehire_flag_id, :conduct_id, :external_matter_history_id , :category_id, \
  :last_pms_performance_rating, :ctc_on_hire, :ctc_on_severance, :notice_period_served_id, :notice_period_paid_id, \
  :full_n_final_status_id, :employee_id, :employer_id


  validates :exit_comments, :length => { :in => 10..500}

  validates :rating, :numericality=> { :greater_than_or_equal_to =>1, :less_than_or_equal_to => 10}
  validates :date_of_leaving , :date => { :after => :date_of_joining, :message => 'Date of Leaving should be after Joining only' }
  validates :date_of_leaving , :date => { :after => :resignation_date, :message => 'Date of Leaving should be after Resignation only' }
  validates :resignation_date , :date => { :after => :date_of_joining, :message => 'Date of Resignation should be after Joining only' }

  def self.search_by_employer(employer)
    if search
      where('employer LIKE ?', "%#{employer}%")
    else
      scoped
    end
  end

  def self.search_by_manager(manager)
    if manager
      where('created_by IN (?) or created_by =?', User.search(manager).collect(&:id),manager)
    else
      scoped
    end
  end

  def self.search_all()
    scoped
  end

  def self.search_by_creator(creator)
    if creator
      where('created_by =?', "#{creator}")
    else
      scoped
    end
  end

end
