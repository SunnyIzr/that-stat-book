require 'spec_helper'

describe Lesson do
  it {should have_many (:questions)}
  it {should have_many (:quizzes)}
end
