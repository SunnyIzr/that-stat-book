require 'spec_helper'

describe AnswerSubmission do
  it {should belong_to (:quiz)}
  it {should belong_to (:choice)}
  it {should validate_presence_of (:quiz_id)}
  it {should validate_presence_of (:choice_id)}
end
