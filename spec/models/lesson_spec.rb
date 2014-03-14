require 'spec_helper'

describe Lesson do
  it {should have_many (:questions)}
  it {should have_many (:quizzes)}
  it {should have_many (:videos)}
  it {should validate_presence_of (:title)}
  it {should validate_presence_of (:level)}
  it {should validate_uniqueness_of (:level)}
end
