class Professor < User
  has_many :rosters
  has_many :class_requests, through: :rosters
end