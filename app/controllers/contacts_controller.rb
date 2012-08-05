class ContactsController < ApplicationController
  def index
    @contact = Contact.all
  end
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new params[:contact]
    if @contact.save
      redirect_to contacts_path, flash: { notice: 'New contact created.'}
    else
      render :new
    end
  end

  def destroy
    @contact = Contact.find params[:id]
    if @contact == @current_user
      flash[:notice] = 'Cannot delete yourself.'
      redirect_to :back 
    elsif @contact.destroy
      flash[:notice] = 'Contact Deleted'
      redirect_to :back
    else
      flash[:error] = 'Contact could not be deleted'
      redirect_to :back
    end
  end
  
  def show
    @contact = Contact.find params[:id]
  end

end
