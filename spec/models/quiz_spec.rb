require 'spec_helper'

describe Quiz do
  it {should belong_to (:user)}
  it {should belong_to (:lesson)}
  it {should have_many (:answer_submissions)}
end
