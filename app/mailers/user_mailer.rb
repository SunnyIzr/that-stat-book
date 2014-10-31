class UserMailer < ActionMailer::Base
  default from: 'StatsDojo <notifications@statsdojo.com>'
 
  def completed_quiz_email(user,quiz)
    @user = user
    @quiz = quiz
    subject = @quiz.pass? ? 'Congratulations on Passing!' : 'Your Recent Quiz Attempt'
    mail(to: @user.email, subject: subject).deliver
  end
end