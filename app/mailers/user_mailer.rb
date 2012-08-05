class UserMailer < ActionMailer::Base
  default from: 'no-reply@rebelhold.com'
  
  def reset_password(user)
    @user = user
    mail(to: @user.email, subject: 'Password Reset')
  end
  
end
