require 'spec_helper'

describe "Users" do

  before do
    @user   = FactoryGirl.create :user
    login_as @user
  end

  it 'has user dashboard' do
    page.should have_content "Welcome to your dashboard"
  end

end
