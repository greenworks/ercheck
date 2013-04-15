class Datafile < ActiveRecord::Base
  attr_accessible :name, :records, :status  , :filepath
  mount_uploader :filepath, FilepathUploader
end
