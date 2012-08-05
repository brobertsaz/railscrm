class UsersController < ApplicationController
  before_filter :require_user, only: [:dashboard]
  
  def new
    @identity = env['omniauth.identity']
  end
  
  def show
    @user = User.find params[:id]
  end
  
  def update
    @user = User.find params[:id]
    @user.update_attributes params[:user] 
    redirect_to dashboard_path, alert: 'User Updated'
  end
  
  def forgot_password
    if params[:email]
      @user = User.where(email: params[:email]).first
      if @user
        @user.reset_password
      else
        redirect_to :back, alert: 'Email address not found'
      end
    end
  end
  
  def reset_password
    @user = User.where(token: params[:token]).first
  end

  def update_password
    @user = User.find params[:user_id]
    if @user.update_attributes params[:user]
      redirect_to login_path
    else
      redirect_to reset_password_path(token: @user.token), alert: 'Passwords do not match'
    end
  end
end
