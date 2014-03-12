require 'spec_helper'

describe Lesson do
  it {should have_many (:questions)}
  it {should have_many (:quizzes)}
  it {should validate_presence_of (:title)}
end
