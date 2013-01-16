require 'spec_helper'

describe 'User Registration' do

  it 'registers user' do
    visit root_path
    click_link 'Register'
    fill_in 'First name',            with: 'Test'
    fill_in 'Last name',             with: 'User'
    fill_in 'Email',                 with: 'register_test@example.com'
    fill_in 'Password',              with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    page.should have_content 'You have signed up successfully but your account has not been approved by your administrator yet'
  end

  before do
    @user = FactoryGirl.create :user
    @admin = FactoryGirl.create :admin_user
  end  

  it 'requires approval' do
    visit root_path
    click_link 'Login'
    fill_in 'Email',     with: @user.email
    fill_in 'Password',  with: 'password'
    click_button 'Sign in'
    page.should have_content 'Your account has not been approved by your administrator yet.'
    page.should_not have_content 'Welcome to your Dashboard'
  end

  it 'approves user' do
    login_as @admin
    click_link 'Admin'
    within '.pending-users' do
      page.should have_content "#{@user.email}"
    end
    click_link 'Approve'
    page.should have_content 'User has successfully been appproved'
    ActionMailer::Base.deliveries.last.to.should include @user.email
    ActionMailer::Base.deliveries.last.body.should include 'You have been approved'
  end

  it 'deletes pending user', js: true do
    login_as @admin
    click_link 'Admin'
    within '.pending-users' do
      click_link 'Delete'
    end
    page.driver.browser.switch_to.alert.accept
    page.should have_content 'User has successfully been deleted'    
  end

end   

describe "User Dashboard" do

  before do
    @user   = FactoryGirl.create :approved_user
    @lead   = FactoryGirl.create :lead, first_name: 'Bill', last_name: 'Gates', phone: '8885551212', interested_in: 'ios', lead_status: 'new', lead_source: 'web', lead_owner: @user.email
    @task = FactoryGirl.create :task, lead_for_task: @lead.first_name, assigned_to: @user.email
    login_as @user
  end

  it 'has user dashboard' do
    page.should have_content "Welcome to your Dashboard"
  end

  it 'has quick links' do
    page.should have_content 'New Lead'
    page.should have_content 'New Task'
    page.should have_content 'New Contact'
    page.should have_content 'New Account'
    page.should have_content 'New Opportunity'
  end

  it 'links to new lead' do
    click_link 'New Lead'
    page.should have_content 'Lead Info'
  end

  it 'links to new task' do
    click_link 'New Task'
    page.should have_content 'Task name'
  end

  it 'links to new contact' do
    click_link 'New Contact'
    page.should have_content 'First name'
  end
  
  it 'links to new account' do
    click_link 'New Account'
    page.should have_content 'Name'
  end 

  it 'links to new opportunity' do
    click_link 'New Opportunity'
    page.should have_content 'Opportunity name'
  end

  it 'has additional settings'do
    page.should have_content 'Settings'
  end

  it 'shows leads assigned' do
    page.should have_content @lead.full_name
    page.should have_content @lead.company
    page.should have_content @lead.lead_status.to_s.capitalize
    page.should have_content @lead.created_at.to_date
  end

  it 'shows tasks assigned' do
    page.should have_content @task.task_name.titleize
    page.should have_content @task.due_date
    page.should have_content @task.task_type.titleize
    page.should have_content @task.lead_for_task.titleize
  end

end
