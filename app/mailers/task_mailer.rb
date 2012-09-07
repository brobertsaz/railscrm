class TaskMailer < ActionMailer::Base
  default from: 'no-reply@rebelhold.com'

  def notify_new_task(user, task)
    @user = user
    @task = task
    mail(to: @user.email, subject: 'A new task has been assigned to you on RailsCRM')
  end
  
  def notify_updated_task(user, task) 
    @user = user
    @task = task
    mail(to: @user.email, subject: 'A task you have been assigned to on RailsCRM has been updated')
  end
end
