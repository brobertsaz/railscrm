require 'spec_helper'

describe "Opportunities" do

  before do
    @user     = FactoryGirl.create :user
    @lead     = FactoryGirl.create :lead, email: 'test@test.com', first_name: 'Jenny', last_name: 'Smith'
    @account  = FactoryGirl.create :account
    login_as @user
  end
  
  it 'creates an opportunity', js: true do
  	click_link 'Opportunities'
    click_link 'Create New Opportunity'
    # current_path.should == new_opportunity_path

    fill_in 'opportunity_name', 		     with: 'Next Big Deal'
    select 'Account name', 					     from: 'opportunity_account_name'
    select 'New Customer', 					     from: 'opportunity_type'
    fill_in 'opportunity_amount', 	     with: '10,000'
    select 'Proposal', 							     from: 'opportunity_stage'
    select "#{@user.email}",				     from: 'opportunity_owner'
    fill_in 'opportunity_closing_date',  with: '09/11/2012'
    fill_in 'opportunity_probability', 	 with: '50%'
    fill_in 'opportunity_contact_name',	 with: 'Mister Smith'
    fill_in 'opportunity_comments', 		 with: 'Lets nail this one'
    click_button 'Create Opportunity'

    page.should have_content 'New Opportunity Created'
  end

end