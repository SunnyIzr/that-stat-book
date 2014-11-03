class UserMailer < ActionMailer::Base
  default from: 'StatsDojo <notifications@statsdojo.com>'
 
  def completed_quiz_email(user,quiz)
    @user = user
    @quiz = quiz
    subject = @quiz.pass? ? 'Congratulations on Passing!' : 'Your Recent Quiz Attempt'
    mail(to: @user.email, subject: subject).deliver
  end
  
  def new_student_request(class_request)
    @class_request = class_request
    @user = @class_request.user
    @professor = @class_request.professor
    subject = 'You have a new student request!'
    mail(to: @professor.email, subject: subject).deliver
  end
end