require 'spec_helper'

describe Question do
  it {should have_many (:choices)}
  it {should belong_to (:lesson)}
end
