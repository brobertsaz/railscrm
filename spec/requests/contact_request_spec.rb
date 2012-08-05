require 'spec_helper'

describe 'Contact requests' do

  before do
    @user   = FactoryGirl.create :user
    login_as @user
  end

  context 'creates a new contact' do
    before do
      click_link 'Contacts'
      click_link 'Create Contact'
      fill_in "contact_first_name", with: 'Bob'
      fill_in "contact_last_name",  with: 'Roberts'
      fill_in "contact_company",    with: 'RebelHold'
      fill_in "contact_email",      with: 'bob@rebelhold.com'
      fill_in "contact_phone",      with: '480-555-1212'
      fill_in "contact_address",    with: '123 Fake St. Fakerton, AZ 12345'
      click_button 'Create Contact'
    end
    
    it 'has contact information' do
      Contact.last.first_name.should  == 'Bob'      
      Contact.last.last_name.should   == 'Roberts'     
      Contact.last.company.should     == 'RebelHold'      
      Contact.last.email.should       == 'bob@rebelhold.com'      
      Contact.last.phone.should       == '480-555-1212'      
      Contact.last.address.should     == '123 Fake St. Fakerton, AZ 12345'
    end
  end

  context 'deletes a contact' do
    
    before do
      @lead   = FactoryGirl.create :lead
    end
    
    it 'deletes contact information' do
      pending 'I dont know how to run a test for this. Sorry. Rick'
      @contact_count = Contact.all.count
      click_link 'Contacts'
      click_link 'Delete'
      @contact_count = @contact_count - 1
      Contact.all.count.should == @contact_count
    end

    
  end
end