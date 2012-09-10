require 'spec_helper'

describe "Opportunities" do

  before do
    @user     = FactoryGirl.create :user
    @account  = FactoryGirl.create :account
    login_as @user
  end
  
  it 'creates an opportunity' do
  	click_link 'Opportunities'
    click_link 'Create New Opportunity'

    fill_in 'opportunity_opportunity_name', 		 with: 'Next Big Deal'
    select 'Account name', 					             from: 'opportunity_account_name'
    select 'New Customer', 					             from: 'opportunity_type'
    fill_in 'opportunity_amount', 	             with: '10,000'
    select 'Proposal', 							             from: 'opportunity_stage'
    select "#{@user.email}",				             from: 'opportunity_owner'
    fill_in 'opportunity_closing_date',          with: '09/11/2012'
    fill_in 'opportunity_probability', 	         with: '50%'
    fill_in 'opportunity_contact_name',	         with: 'Mister Smith'
    fill_in 'opportunity_comments', 		         with: 'Lets nail this one'
    click_button 'Create Opportunity'

    page.should have_content 'New Opportunity Created'
  end

  context 'with created opportunity' do

    before do
      @opportunity = FactoryGirl.create :opportunity, owner: @user.email, account_name: @account.name
    end

    it 'edits opportunity' do
      click_link 'Opportunities'
      click_link 'Edit'

      fill_in 'opportunity_opportunity_name',   with: 'New Deal Name'
      fill_in 'opportunity_amount',             with: '20,000'
      click_button 'Update'
      page.should have_content 'Opportunity Successfully Updated'
    end

    it 'deletes an opportunity' do
      click_link 'Opportunities'
      click_link 'Delete'
      page.should have_content 'Opportunity Deleted'
    end
  end

end