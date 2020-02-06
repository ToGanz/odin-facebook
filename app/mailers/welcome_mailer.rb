class WelcomeMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'https://facebook-5890.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end


end
