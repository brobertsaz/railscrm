require 'spec_helper'

describe 'Accounts' do

  before do
    @user   = FactoryGirl.create :approved_user
    login_as @user
  end

  it 'creates a new account' do
    click_link 'Accounts'
    click_link 'Create Account'
    fill_in 'account_name',       with: 'Potato Factory'
    fill_in 'account_phone',      with: '555-1212'
    fill_in 'account_website',    with: 'www.spud.com'
    fill_in 'account_email',      with: 'famouspotatos@yahoo.com'
    fill_in 'account_address',    with: '123 W. Main St. Eloy, AZ'
    click_button 'Create Account'
    page.should have_content 'New Account Created'
    Account.count.should == 1
  end
    
  it 'has required fields' do
    click_link 'Accounts'
    click_link 'Create Account'
    fill_in 'account_name',       with: 'Potato Factory'
    fill_in 'account_website',    with: 'www.spud.com'
    fill_in 'account_email',      with: 'famouspotatos@yahoo.com'
    fill_in 'account_address',    with: '123 W. Main St. Eloy, AZ'
    click_button 'Create Account'
    page.should have_content "can't be blank"
    page.should_not have_content 'New Account Created'
    Account.count.should == 0
  end

  context 'with an existing account' do
    before do
      @account   = FactoryGirl.create :account
    end

    it 'deletes account' do
      click_link 'Accounts'
      click_link 'Delete'
      page.should have_content 'Account Deleted'
    end

    it 'edits account' do
      click_link 'Accounts'
      within '.table-striped' do
        click_link 'Edit'
      end
      fill_in 'account_name', with: 'Potato Factory'
      click_button 'Update Account'
      page.should have_content 'Account Updated'
      @account.reload
      @account.name.should == 'Potato Factory'
    end 

  end

end