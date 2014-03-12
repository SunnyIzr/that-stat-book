require 'spec_helper'

describe AnswerSubmission do
  it {should belong_to (:quiz)}
  it {should belong_to (:choice)}
end
