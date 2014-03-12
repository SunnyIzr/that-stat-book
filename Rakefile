# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

ThatStatBook::Application.load_tasks

desc 'Seed Database with Dummy Data'
task 'db:seed_users' => :environment do
  10.times do
    user = User.new
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.email = Faker::Internet.email
    user.save
  end
end
task 'db:seed_lessons' => :environment do
  5.times do
    lesson = Lesson.new
    lesson.title = Faker::Company.catch_phrase
    lesson.description = Faker::Lorem.paragraphs(2)
    lesson.save
  end
end
task 'db:seed_questions' => :environment do
  Lesson.all.each do |lesson|
    100.times do
      question = Question.new
      question.lesson = lesson
      question.question = Faker::Company.bs.capitalize + '?'
      question.save
    end
  end
end
task 'db:seed_choices' => :environment do
  Question.all.each do |question|
    3.times do
      choice = Choice.new
      choice.question = question
      choice.choice = Faker::Lorem.sentence
      choice.save
    end
    choice = Choice.new
    choice.question = question
    choice.choice = question.question.chop
    choice.is_correct = true
    choice.save
  end
end
