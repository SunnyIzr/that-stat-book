require 'spec_helper'

describe Roster do
  it {should belong_to (:professor)}
  it {should have_and_belong_to_many (:users)}
  it {should have_and_belong_to_many (:lessons)}
end
