require 'spec_helper'

describe "Leads" do

  before do
    @user   = FactoryGirl.create :user
    @user2  = FactoryGirl.create :user, email: 'test2@example.com', first_name: 'Jim Jones'
    login_as @user
  end
  
  it 'should create new lead' do
    click_link 'Leads'
    click_link 'Create Lead'
    current_path.should_be new_lead_path
    
    fill_in 'lead_first_name',  with: 'Bill'
    fill_in 'lead_last_name',   with: 'Gates'
    fill_in 'lead_phone',       with: '8005551212'
    fill_in 'lead_email',       with: 'bill@ms.com'
    fill_in 'lead_company',     with: 'Microsoft'
    select 'Web Application',   from: 'lead_interested_in'
    fill_in 'lead_comments',    with: 'Needs ASAP'
    select 'New',               from: 'lead_lead_status'
    select 'Web Lead',          from: 'lead_lead_source'
    select "#{@user2.email}",   from: 'lead_lead_owner'
    click_button 'Create Lead'
    page.should have_content 'New Lead Created'
  end
  
  context 'with created lead' do
  
    before do
      @lead   = FactoryGirl.create :lead, first_name: 'Bill', last_name: 'Gates', phone: '8885551212', interested_in: 'ios', lead_status: 'new', lead_source: 'web', lead_owner: @user.email
      @lead2  = FactoryGirl.create :lead, first_name: 'Bob', last_name: 'Marley', phone: '8005551212', interested_in: 'web_app', lead_status: 'contacted', lead_owner: @user.email, lead_source: 'referral', email: 'bob@marley.com'
    end
    
    it 'should edit a lead' do
      visit lead_path @lead
      fill_in 'lead_company', with: 'XYZ'
      select 'Contacted', from: 'lead_lead_status'
      click_button 'Update'
      page.should have_content 'Lead Updated'
    end
    
    it 'should show all leads' do
      visit leads_path
      page.should have_content 'Bill Gates'
      page.should have_content 'Bob Marley'
      page.should have_content '8885551212'      
      page.should have_content '8005551212'
      page.should have_content 'New'
      page.should have_content 'Contacted'
      page.should have_content 'Assigned to'
      #page.should have_content Date.today.to_s
    end
    
    it 'assigns lead to user' do
      visit lead_path @lead
      select "#{@user2.email}", from: 'lead_lead_owner'
      click_button 'Update'
      page.should have_content 'Lead Updated'
      visit leads_path
      page.should have_content @user2.email
    end
    
    it 'reassigns lead' do 
      visit lead_path @lead
      select "#{@user.email}", from: 'lead_lead_owner'
      click_button 'Update'
      page.should have_content 'Lead Updated'
      visit leads_path
      page.should have_content @user.email
    end
    
    it 'deletes a lead' do
      visit leads_path
      page.should have_content 'Bill Gates'
      click_link 'Delete'
      page.should have_content 'Lead Deleted'
      page.should_not have_content 'Bill Gates'
    end
    
    it 'adds a note', js: true do
      visit lead_path @lead
      click_button 'Add a Note'
      fill_in 'lead_note_note_content', with: 'this is a note'
      click_button 'Add Note'
      page.should have_content 'Lead Updated'
      page.should have_content 'this is a note'
    end
          
  end
  
end
