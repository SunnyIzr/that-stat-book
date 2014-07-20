class Roster < ActiveRecord::Base
  belongs_to :professor
  has_many :users, through: :rosters_users
  has_many :lessons, through: :lessons_rosters
end