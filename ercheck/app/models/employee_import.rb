class EmployeeImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_employees.map(&:valid?).all?
      imported_employees.each(&:save!)
      true
    else
      imported_employees.each_with_index do |employee, index|
        employee.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+1}: #{message}"
        end
      end
      false
    end
    (Employement.all - Employement.all.uniq_by{|r| [r.employee_id, r.employer_id, r.date_of_joining ]}).each{ |d| d.destroy }

  end

  def imported_employees
    @imported_employees ||= load_imported_employees
  end



  def load_imported_employees
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row= spreadsheet.row(i)
      employee = Employee.find_or_initialize_by_pancard(row[1])
      university  = University.find_or_create_by_name(row[3])
      board = Board.find_or_create_by_name(row[9])
      highest_qualification = HighestQualification.find_or_create_by_name(row[10])


      if Employer.find_by_employer_code(row[14]).nil?

        message =     "Unknown employer code #{row[14]}. Please use one of  "
        Employer.find_each do |employer|
            message += "#{employer.employer_code}, "
        end

        raise  message


      end

      employee.attributes = {:name => row[0],
                            :date_of_birth => row[2],
                            :university_id => university.id,
                            :ssc_marksheet_code => row[4],
                            :surname => row[5],
                            :mother_name => row[6],
                            :father_name => row[7],
                            :metric_passing_year => row[8],
                            :board_id => board.id,
                            :highest_qualification_id => highest_qualification.id,
                            :highest_qualification_passing_year => row[11],
                            :mobile => row[12],
                            :res_landline => row[13],
                            :created_by => 1,
                            :is_published => 0,
                            :status_id => 1,
      }

      employee.save

      employement = Employement.find_or_initialize_by_employee_id_and_employer_id(employee.id, Employer.find_by_employer_code(row[14]))

      employement.attributes= { :employee_id => employee.id ,
                                   :employer_id =>  Employer.find_or_create_by_employer_code(row[14]).id,
                                  :date_of_joining => row[15],
                                  :date_of_leaving  => row[16],
                                  :exit_comments => row[17],
                                  :rating => row[18],
                                  :employee_code => row[19],
                                  :resignation_date => row[20],
                                  :designation_id => Designation.find_or_create_by_name(row[21]).id,
                                  :department_id => Department.find_or_create_by_name(row[22]).id,
                                  :function_id =>Function.find_or_create_by_name(row[23]).id,
                                  :recorded_address => row[24],
                                  :severance_id => Severance.find_or_create_by_name(row[25]).id,
                                  :reason_id => Reason.find_or_create_by_name(row[26]).id,
                                  :other_reason => row[27],
                                  :termination_discharge_reason_id =>TerminationDischargeReason.find_or_create_by_name(row[28]).id,
                                  :regret_flag => row[29],
                                  :rehire_flag_id=> RehireFlag.find_or_create_by_name(row[30]).id,
                                  :conduct_id =>Conduct.find_or_create_by_name(row[31]).id,
                                  :external_matter_history_id => ExternalMatterHistory.find_or_create_by_name(row[32]).id,
                                  :history_impact_id =>HistoryImpact.find_or_create_by_name(row[33]).id,
                                  :category_id=> Category.find_or_create_by_name(row[34]).id,
                                  :last_pms_performance_rating => row[35],
                                  :previous_pms_year_performance_rating => row[36],
                                  :before_previous_pms_year_performance_rating => row[37],
                                  :ctc_on_hire => row[38],
                                  :ctc_on_severance => row[39],
                                  :notice_period_served_id => NoticePeriodServed.find_or_create_by_name(row[40]).id,
                                  :notice_period_paid_id => NoticePeriodPaid.find_or_create_by_name(row[41]).id,
                                  :full_n_final_status_id => FullNFinalStatus.find_or_create_by_name(row[42]).id,
                                  :settlement_pending_side_id => SettlementPendingSide.find_or_create_by_name(row[43]),
                                      :mobile => row[44],
                                  :landline => row[45],
                                  :highest_qualification_id => HighestQualification.find_or_create_by_name(row[46]).id,
                                  :highest_qualification_year=> row[47]
      }

     #employer_code,date_of_joining,date_of_leaving ,exit_comments,rating,employee_code,resignation_date,designation_name,department_name,department_name,function_name,recorded_address,severance_name,reason_name,other_reason,termination_discharge_reason_name,regret_flag,rehire_flag_name,conduct_name,external_matter_history_name,history_impact_name,category_name,last_pms_performance_rating,previous_pms_year_performance_rating,before_previous_pms_year_performance_rating,ctc_on_hire,ctc_on_severance,notice_period_served_name,notice_period_paid_name,full_n_final_status_name,settlement_pending_side_name,mobile,landline,highest_qualification_name,highest_qualification_year

      employement

    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
