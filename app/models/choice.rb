class Choice < ActiveRecord::Base
  belongs_to :question, inverse_of: :choices
  validates_presence_of :choice
  validates_presence_of :question

end
