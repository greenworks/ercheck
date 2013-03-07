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
  belongs_to :designation
  belongs_to :function
  belongs_to :department
  belongs_to :highest_qualification


  belongs_to :approver, :class_name => "User",   :foreign_key => "approved_by"
  belongs_to :creator,  :class_name => "User",   :foreign_key => "created_by"

  attr_accessible :employer_attributes, :employees_attributes, :employee_id, :employer_id, :date_of_joining, :date_of_leaving , :exit_comments, :rating, :status_id, \
  :created_by, :approved_by, :is_published, :employee_code, :resignation_date, :designation_id, :department_id, :function_id, \
  :recorded_address, :severance_id, :reason_id, :other_reason, :termination_discharge_reason_id, \
  :other_termination_discharge_reason, :regret_flag, :rehire_flag_id, :conduct_id, :external_matter_history_id, \
  :history_impact_id, :category_id, :last_pms_performance_rating, :previous_pms_year_performance_rating, \
  :before_previous_pms_year_performance_rating, :ctc_on_hire, :ctc_on_severance, :notice_period_served_id, \
  :notice_period_paid_id, :full_n_final_status_id, :settlement_pending_side_id, :highest_qualification_id, \
  :highest_qualification_year, :mobile, :landline

  validates_presence_of  :date_of_joining, :date_of_leaving, :severance_id, :reason_id, :conduct_id, :external_matter_history_id , :category_id, \
  :ctc_on_severance, :notice_period_served_id, :notice_period_paid_id, \
  :full_n_final_status_id, :employee_id, :employer_id

  #validates :exit_comments, :length => { :in => 10..500}

  #validates :rating, :numericality=> { :greater_than_or_equal_to =>1, :less_than_or_equal_to => 10}
  validates :date_of_leaving , :date => { :after => :date_of_joining, :message => 'Date of Leaving should be after Joining only' }
  validates :date_of_leaving , :date => { :on_or_after => :resignation_date, :message => 'Date of Leaving should be on/after Resignation only' }
  validates :resignation_date , :date => { :after => :date_of_joining, :message => 'Date of Resignation should be after Joining only' }
  validates :date_of_joining, :timeliness => {:on_or_before => lambda { Date.current }, :type => :date}
  validates :highest_qualification_year ,:numericality=> { :greater_than_or_equal_to =>1900},:allow_blank => true
  validates :landline ,:numericality=> { :greater_than_or_equal_to =>0},:allow_blank => true
  validates :mobile ,:numericality=> { :greater_than_or_equal_to =>0},:allow_blank => true

  def self.search_by_employer(employer)
    if search
      where('employer LIKE ?', "%#{employer}%")
    else
      scoped
    end
  end


  def self.search_by_manager(manager)
    if manager
      where('created_by IN (?) or created_by =?', User.search_reporting_users(manager).collect(&:id),manager)
    else
      scoped
    end
  end


  def self.search_by_status(status)
    if status
      where('status_id = (?) ', status)
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


  def self.search_employments_submitted_by_team(current_user)
    if  User.find(current_user).role.name=="manager"
      where(' status_id =? and created_by IN (?)', Status.find_by_name('Submitted') , User.search_reporting_users(current_user).collect(&:id))
    else
      where(' status_id =? and created_by IN (?)', Status.find_by_name('Submitted') , current_user)
    end
  end


  def self.search_employments_approved(current_user)
    if  User.find(current_user).role.name=="manager"
      where(' status_id =? and created_by IN (?)', Status.find_by_name('Approved') , User.search_reporting_users(current_user).collect(&:id))
    else
      where(' status_id =? and created_by IN (?)', Status.find_by_name('Approved') , current_user)
    end
  end


  def self.search_employments_published(current_user)
    if  User.find(current_user).role.name=="manager"
      where(' status_id =? and created_by IN (?)', Status.find_by_name('Published') , User.search_reporting_users(current_user).collect(&:id))
    else
      where(' status_id =? and created_by IN (?)', Status.find_by_name('Published') , current_user)
    end
  end


  def self.search_accessible_employments(current_user)
    if  User.find(current_user).role.name=="manager"
      where(' created_by IN (?)', User.search_reporting_users(current_user).collect(&:id))
    else
      where(' created_by =?', "#{current_user}")
    end
  end


  def self.search_all_published_employments(current_user)
    if  User.find(current_user).role.name=="manager"
      where(' created_by IN (?)', User.search_reporting_users(current_user).collect(&:id))
    else
      where(' created_by =?', "#{current_user}")
    end
  end
end
