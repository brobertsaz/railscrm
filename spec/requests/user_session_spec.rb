require 'spec_helper'

describe 'UserSession' do

  context 'redirecting visitor' do

    it 'redirects a visitor to the root path' do
      visit dashboard_path
      
      current_path.should == new_user_path
    end

  end

  context 'creating new user' do

    before do
      visit new_user_path
      fill_in 'name',                   with: 'Test User'
      fill_in 'email',                  with: 'test@example.com'
      fill_in 'password',               with: 'password'
      fill_in 'password_confirmation',  with: 'password'

      click_button 'Create User'
    end
  
    it 'creates' do
      User.count.should       == 1
      User.first.name.should  == 'Test User'
      User.first.email.should == 'test@example.com'
    end
  
    it 'sets current_user' do
      @user = User.first
      current_path.should == dashboard_path
    end

  end
  
  context 'existing user' do

    before do
      @user = FactoryGirl.create :user
      visit login_path
    end
    
    context 'logout' do

      before do
        login_as @user
        visit dashboard_path
      end
      
      it 'has a link' do
        page.should have_content 'Logout'
      end
      
      it 'can logout' do
        click_link 'Logout'
        
        @current_user.should_not be
      end
      
      it 'redirects to root' do
        click_link 'Logout'
        
        current_path.should == root_path
      end
      
      it 'notifies the user' do
        click_link 'Logout'
        
        page.body.should have_content 'You have logged out'
      end

    end

    context 'login' do

      it 'has a link' do
        visit root_path
        click_link 'Login'
        
        current_path.should == login_path
      end
      
      it 'can login' do
        fill_in 'Email',                  with: @user.email
        fill_in 'password',               with: 'password'
        click_button 'Login'
      
        current_path.should == dashboard_path
      end

    end

    context 'invalid credentials' do

      context 'redirect to login' do

        it 'if invalid email' do
          fill_in 'Email',       with: 'not_right_password@example.com'
          fill_in 'password',    with: 'password'
          click_button 'Login'
      
          current_path.should == login_path
        end    
      
        it 'if invalid password' do
          fill_in 'Email',       with: @user.email
          fill_in 'password',    with: 'wrong_password'
          click_button 'Login'
      
          current_path.should == login_path
        end

      end
      
      context 'error warnings' do

        it 'if invalid email' do
          fill_in 'Email',       with: 'not_right_password@example.com'
          fill_in 'password',    with: 'password'
          click_button 'Login'
          
          page.body.should have_content 'Invalid email or password'
        end
        
        it 'if invalid password' do
          fill_in 'Email',       with: @user.email
          fill_in 'password',    with: 'wrong_password'
          click_button 'Login'

          page.body.should have_content 'Invalid email or password'
        end

      end

    end

    context 'forgotten password' do

      context 'request' do

        before do
          click_link 'Forgot Password'        
        end
        
        context 'failure' do

          before do
            fill_in 'email', with: 'wrong_email@example.com'
            click_button 'Reset Password'
          end
          
          it 'shows error' do
            page.body.should have_content 'Email address not found'
          end
          
          it 'redirects to forgot password path' do
            current_path.should == forgot_password_path
          end

        end

        context 'success email' do

          it 'sends' do
            fill_in 'email', with: @user.email
            click_button 'Reset Password'
          
            open_last_email_for(@user.email).should be
          end
      
          it 'has reset link' do
            open_last_email_for(@user.email)
            visit_in_email(reset_password_url(token:  @user.token))
            should_be_on reset_password_path(token:   @user.token)
          end

        end

      end

      context 'reset form' do

        before do
          @user.create_token
          visit reset_password_path(token: @user.token)
        end
        
        it 'success redirects to login' do
          fill_in 'user_password',              with: 'newpassword'
          fill_in 'user_password_confirmation', with: 'newpassword'
          click_button 'Change Password'
          
          current_path.should == login_path
        end
        
        context 'failure' do

          before do
            fill_in 'user_password',              with: 'newpassword'
            fill_in 'user_password_confirmation', with: ''
            click_button 'Change Password'
          end
          
          it 'redirects to reset form' do
            current_path.should == reset_password_path(token: @user.token)
          end
        
          it 'shows a error if passwords do not match' do
            page.body.should have_content 'Passwords do not match'
          end

        end

      end

    end

  end

end
