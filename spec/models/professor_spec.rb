require 'spec_helper'

describe Professor do
  it {should have_many (:rosters)}
end
