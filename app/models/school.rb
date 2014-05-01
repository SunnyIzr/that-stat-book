class School < ActiveRecord::Base
  has_many :students
  validates_uniqueness_of :school
  validates_presence_of :school
  validates_presence_of :state
  validates_presence_of :country
end
