class ClassRequest < ActiveRecord::Base
  validates_presence_of :user
  validates_presence_of :roster
  belongs_to :user
  belongs_to :roster
  has_one :professor, through: :roster
  validate :cannot_belong_to_professor_or_admin
  validate :cannot_create_duped_request
  
  def cannot_belong_to_professor_or_admin
    if self.user.present? && !self.user.student?
      errors.add(:user_id, "must be a student")
    end
  end
  
  def cannot_create_duped_request
    unless ClassRequest.where(user_id: self.user_id, roster_id: self.roster_id).empty?
      errors.add(:roster_id, "request already exists")
    end
  end
  
end