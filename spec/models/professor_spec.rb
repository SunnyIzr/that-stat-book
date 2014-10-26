require 'spec_helper'

describe Professor do
  it {should have_many (:rosters)}
  it {should have_many (:class_requests)}
end
