# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

ThatStatBook::Application.load_tasks

desc 'Seed Database with Dummy Data'
task 'db:seed_belts' => :environment do
  belts = %w[yellow orange green blue purple red brown black]
  belts.each do |belt|
    Belt.create(belt: belt)
  end
  Belt.all
end
task 'db:seed_lessons' => :environment do
  24.times do |i|
    lesson = Lesson.new
    lesson.title = Faker::Company.catch_phrase
    lesson.level = i + 1
    lesson.belt = Belt.all[i/3]
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
  
