class Employee < ActiveRecord::Base
    has_many :employements #, :dependent => :destroy

    accepts_nested_attributes_for :employements, :allow_destroy => true
                                                 #:reject_if => lambda { |a| a[:text].blank? },

    has_many :employers, :through => :employements

    belongs_to :university
    belongs_to :board
    belongs_to :status

    belongs_to :approver, :class_name => "User",   :foreign_key => "approved_by"
    belongs_to :creator,  :class_name => "User",   :foreign_key => "created_by"

    attr_accessible  :employement_attributes, :employement_id, :date_of_birth, :name, :pancard, \
    :university_id, :board_id ,:status_id, :created_by, :approved_by, :is_published, :ssc_marksheet_code, \
    :surname, :mother_name, :father_name, :string, :metric_passing_year, \
    :highest_qualification, :highest_qualification_passing_year, :mobile, :res_landline

    validates_presence_of  :date_of_birth, :name, :pancard,  :university_id ,:ssc_marksheet_code, \
    :metric_passing_year, :board_id

    validates :name, :length => { :in => 3..50, :message => "At least 3 characters expected in name" }
    validates :name, :format => { :with => /\A[a-zA-Z\s]+\z/,:message => "Only letters allowed" }
    validates :surname, :format => { :with => /\A[a-zA-Z\s]+\z/,:message => "Only letters allowed" }
    validates :mother_name, :format => { :with => /\A[a-zA-Z\s]+\z/,:message => "Only letters allowed" }
    validates :father_name, :format => { :with => /\A[a-zA-Z\s]+\z/,:message => "Only letters allowed" }

    validates :pancard, :length => { :is => 10}
    validates :pancard, :uniqueness => {:case_sensitive => false,:message => "Employee already exists with this PAN ! "}
    validates :ssc_marksheet_code, :uniqueness => {:case_sensitive => false,:message => "Employee already exists with this ssc marksheet id ! "}

=begin
    validate :ensure_approved_before_publish,
             :on => :update
=end

    def self.search(search)
      if search
        where('name LIKE ?', "%#{search}%")
      else
        scoped
      end
    end

    def self.search_by_manager(manager)
        if manager
          where(' created_by IN (?) or created_by =?', User.search(manager).collect(&:id),manager)
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

    def self.search_by_pancard(pancard)
      if pancard
        where('pancard =?', "#{pancard}")
        #where('pancard =? or date_of_birth=?', "#{pancard}", "#{date_of_birth}")
      end
    end

    def self.search_by_marksheet(marksheet)
      if marksheet
        where('ssc_marksheet_code =?', "#{marksheet}")
        #where('ssc_marksheet_code =?', "#{marksheet}", "#{date_of_birth}")
      end
    end

    def self.search_accessible_employees(currentuser)
      if currentuser
          if  User.find(currentuser).role.name=="manager"
             where(' status_id !=? and created_by IN (?)', Status.find_by_name('Approved') , User.search(currentuser).collect(&:id))
          else
             where('created_by =?', "#{currentuser}")
          end
      else
        scoped
      end
    end

=begin
    def self.fetchcsv(input_csv) #'C:\\DATA\\univ.csv'
      include CsvMapper

      results = CsvMapper.import(input_csv) do
        map_to Employee
        # Map to the Employee ActiveRecord class (defined above) instead of the default OpenStruct.

        after_row lambda{|row, university| university.save }  # Call this lambda and save each record after it's parsed.

        start_at_row 1
        [name,pancard,date_of_birth,university_id,created_by,ssc_marksheet_code]
      end
    end
=end

=begin
    def ensure_approved_before_publish
      if self.status.name != "Approved"
        errors.add('Record must be approved before publish')
      end
    end
=end
end
