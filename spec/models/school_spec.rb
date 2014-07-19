require 'spec_helper'

describe School do
  it {should have_many (:users)}
  it {should validate_uniqueness_of (:school)}
  it {should validate_presence_of (:school)}
end
