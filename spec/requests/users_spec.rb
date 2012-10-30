require 'spec_helper'

describe "User Dashboard" do

  before do
    @user   = FactoryGirl.create :user
    @lead   = FactoryGirl.create :lead, first_name: 'Bill', last_name: 'Gates', phone: '8885551212', interested_in: 'ios', lead_status: 'new', lead_source: 'web', lead_owner: @user.email
    @task = FactoryGirl.create :task, lead_for_task: @lead.first_name, assigned_to: @user.email
    login_as @user
  end

  it 'has user dashboard' do
    page.should have_content "Welcome to your Dashboard"
  end

  it 'has quick links' do
    page.should have_content 'Create New Lead'
    page.should have_content 'Create New Task'
    page.should have_content 'Create New Contact'
    page.should have_content 'Create New Account'
    page.should have_content 'Create New Opportunity'
  end

  it 'links to new lead' do
    click_link 'Create New Lead'
    page.should have_content 'Lead Info'
  end

  it 'links to new task' do
    click_link 'Create New Task'
    page.should have_content 'Task name'
  end

  it 'links to new contact' do
    click_link 'Create New Contact'
    page.should have_content 'First name'
  end
  
  it 'links to new account' do
    click_link 'Create New Account'
    page.should have_content 'Name'
  end 

  it 'links to new opportunity' do
    click_link 'Create New Opportunity'
    page.should have_content 'Opportunity name'
  end

  it 'shows leads assigned' do
    page.should have_content @lead.full_name
    page.should have_content @lead.company
    page.should have_content @lead.lead_status.to_s.capitalize
    page.should have_content @lead.created_at.to_date
  end

  it 'shows tasks assigned'


end
