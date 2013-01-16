class LeadMailer < ActionMailer::Base
  default from: 'no-reply@rebel-outpost.com'

  def notify_new_lead(user, lead)
    @user = user
    @lead = lead
    mail(to: @user, subject: 'A new lead has been assigned to you on RailsCRM')
  end
  
  def notify_updated_lead(user, lead) 
    @user = user
    @lead = lead
    mail(to: @user, subject: 'A lead you have been assigned to on RailsCRM has been updated')
  end

  def notify_web_form_lead(user, lead)
    @user = user
    @lead = lead
    mail(to: @user, subject: 'A new web form lead has been assigned to you on RailsCRM')
  end
end