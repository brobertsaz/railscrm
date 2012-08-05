require 'spec_helper'

describe 'Accounts' do

  before do
    @user   = FactoryGirl.create :user
    login_as @user
  end

  context 'creates a new account' do
    before do
      pending 'Ill get back to this later, moving on to easier stories for now'
      click_link 'Account'
      click_link 'Create Account'

      fill_in 'account_name',       with: 'Potato Factory'
      select @user.full_name,       from: account_assigned_to
      fill_in 'account_phone',      with: '555-1212'
      fill_in 'account_website',    with: 'www.spud.com'
      fill_in 'account_email',      with: 'famouspotatos@yahoo.com'
      fill_in 'account_address',    with: '123 W. Main St. Eloy, AZ'
      click_button 'Update account'
    end
    
    it 'has required fields' do

      Account.first.name.should         == 'Potato Factory'
      Account.first.assigned_to.should  == @user.full_name
      Account.first.phone.should        == '555-1212'
      Account.first.website.should      == 'www.spud.com'
      Account.first.email.should        == 'famouspotatos@yahoo.com'
      Account.first.address.should      == '123 W. Main St. Eloy, AZ'
    end
  end

  context 'delete an account' do
    before do
      @task   = FactoryGirl.create :account
    click_link 'Accounts'
    click_link 'Delete'
    page.should have_content 'Account Deleted'
    end

    it 'does not exist after deletion' do
    Task.first.should_not be
    end
  end

end