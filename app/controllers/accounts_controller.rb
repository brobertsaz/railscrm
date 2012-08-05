class AccountsController < ApplicationController

	def index
		@accounts = Account.all
	end

	def new
		@account = Account.new
	end

	def create
    @account = Account.create params[:account]
	    if @account.save
	      redirect_to accounts_path, flash: { notice: 'New Account Created'}
	    else
	      render :new
	    end
	end

	def destroy
    @account = Account.find params[:id]
    if @account.destroy
      flash[:notice] = 'Account Deleted'
      redirect_to :back
    else
      flash[:error] = 'Account could not be deleted'
      redirect_to :back
    end
end
end
