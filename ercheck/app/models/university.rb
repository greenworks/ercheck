

class University < ActiveRecord::Base

  include CsvMapper

  has_many :employees

  attr_accessible :address, :name


  def self.fetchcsv(input_csv) #'C:\\DATA\\univ.csv'
    include CsvMapper

    results = CsvMapper.import(input_csv) do
      map_to University
      # Map to the University  ActiveRecord class (defined above) instead of the default OpenStruct.

      after_row lambda{|row, university| university.save }  # Call this lambda and save each record after it's parsed.

      start_at_row 1
      [name, address]

    end
  end
end
