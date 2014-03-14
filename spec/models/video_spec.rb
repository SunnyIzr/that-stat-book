require 'spec_helper'

describe Video do
  it {should belong_to(:lesson)}
end
