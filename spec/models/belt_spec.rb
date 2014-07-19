require 'spec_helper'

describe Belt do
  it {should have_and_belong_to_many (:users)}
  it {should have_many (:lessons)}
end
