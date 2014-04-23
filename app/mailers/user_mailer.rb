class UserMailer < ActionMailer::Base
  default from: 'StatsDojo <notifications@statsdojo.com>'
 
  def successful_pass_email(user)
    @user = user
    mail(to: @user.email, subject: 'Congratulations on Passing!').deliver
  end
end