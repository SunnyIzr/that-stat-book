require 'spec_helper'

describe Question do
  it {should have_many (:choices)}
  it {should belong_to (:lesson)}
  it {should validate_presence_of (:question)}
end
