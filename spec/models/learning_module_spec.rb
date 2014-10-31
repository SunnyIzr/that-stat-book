require 'spec_helper'

describe LearningModule do
  it {should have_many(:questions)}
  it {should belong_to(:lesson)}
end