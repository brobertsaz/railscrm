require 'spec_helper'

describe "Leads" do

  before do
    @user   = FactoryGirl.create :user
    @user2  = FactoryGirl.create :user, email: 'test2@example.com', first_name: 'Jim Jones'
    login_as @user
  end
  
  it 'should create new lead', js: true do
    click_link 'Leads'
    click_link 'Create Lead'
    current_path.should == new_lead_path
    
    fill_in 'lead_first_name',  with: 'Bill'
    fill_in 'lead_last_name',   with: 'Gates'
    fill_in 'lead_phone',       with: '8005551212'
    fill_in 'lead_email',       with: 'bill@ms.com'
    fill_in 'lead_company',     with: 'Microsoft'
    fill_in 'lead_comments',    with: 'Needs ASAP'
    select2 "#{@user2.email}",  from: 'Lead owner'
    select2 'Web Application',  from: 'Interested in'
    select2 'New',              from: 'Lead status'
    select2 'Web Lead',         from: 'Lead source'
    sleep 1
    click_button 'Create Lead'
    Lead.last.last_name.should == 'Gates'
    page.should have_content 'New Lead Created'
  end

  it 'notifies new lead create', js: true do
    click_link 'Leads'
    click_link 'Create Lead'
    
    fill_in 'lead_first_name',  with: 'Bill'
    fill_in 'lead_last_name',   with: 'Gates'
    fill_in 'lead_phone',       with: '8005551212'
    fill_in 'lead_email',       with: 'bill2@ms.com'
    fill_in 'lead_company',     with: 'Microsoft'
    fill_in 'lead_comments',    with: 'Needs ASAP'
    select2 "#{@user2.email}",  from: 'Lead owner'
    select2 'Web Application',  from: 'Interested in'
    select2 'New',              from: 'Lead status'
    select2 'Web Lead',         from: 'Lead source'
    sleep 1
    click_button 'Create Lead'
    ActionMailer::Base.deliveries.each.count.should == 1
    ActionMailer::Base.deliveries[0].to.should include @user2.email
    ActionMailer::Base.deliveries[0].body.should include 'new lead'
  end
  
  context 'with created lead' do
  
    before do
      @lead   = FactoryGirl.create :lead, first_name: 'Bill', last_name: 'Gates', phone: '8885551212', interested_in: 'ios', lead_status: 'new', lead_source: 'web', lead_owner: @user.email
      @lead2  = FactoryGirl.create :lead, first_name: 'Bob', last_name: 'Marley', phone: '8005551212', interested_in: 'web_app', lead_status: 'contacted', lead_owner: @user.email, lead_source: 'referral', email: 'bob@marley.com'
      @account = FactoryGirl.create :account    
    end
    
    it 'should edit a lead', js: true do
      visit lead_path @lead
      fill_in 'lead_company', with: 'XYZ'
      select2 'Contacted', from: 'Lead status'
      sleep 2
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
    
    it 'assigns lead to user', js: true do
      visit lead_path @lead
      select2 "#{@user2.email}", from: 'Lead owner'
      sleep 2
      click_button 'Update'
      page.should have_content 'Lead Updated'
      visit leads_path
      page.should have_content @user2.email
    end
    
    it 'reassigns lead', js: true do 
      visit lead_path @lead
      select2 "#{@user.email}", from: 'Lead owner'
      sleep 2
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
      click_button 'New Note'
      fill_in 'lead_note_note_content', with: 'this is a note'
      click_button 'Create Note'
      page.should have_content 'Lead Updated'
      page.should have_content 'this is a note'
    end

    it 'converts a lead', js: true do
      visit lead_path @lead
      click_link 'Convert Lead'
      select2 "#{@account.name}", from: 'Account name'
      fill_in 'Opportunity name', with: 'New Opportunity'
      select2 "#{@user.email}", from: 'Opportunity owner'
      count_before = Opportunity.count
      sleep 2
      click_button 'Convert'
      Opportunity.count.should == count_before + 1
      Opportunity.last.opportunity_name.should == 'New Opportunity'
      page.should have_content 'Lead has been converted'
    end
  end

  context 'web-to-lead' do
    it 'creates web-to-lead form' do
      click_link 'Web-to-Lead Form'
      fill_in 'redirect_url',   with: '/index.html'
      check 'First Name'
      check 'Last Name'
      check 'Company'
      check 'Email'
      check 'Phone'
      check 'Address'
      check 'City'
      check 'State'
      check 'Zip'
      check 'Interested In'
      check 'Comments'
      click_button 'Create Form'
      page.should have_content 'Copy the form below and use it anywhere in your website.'
    end
  end

  
end
