require 'spec_helper'

describe Roster do
  it {should belong_to (:professor)}
  it {should have_many (:users)}
  it {should have_many (:lessons)}
end
