class LeadsController < ApplicationController  
  def new
    @lead = Lead.new
    @lead_owner     = User.all.map(&:email)
    @lead_status    = Lead.status
    @lead_sources   = Lead.sources
    @lead_interests = Lead.interests
  end
  
  def create
    @lead = Lead.new params[:lead]
    @lead.update_attributes(assigned_to: @lead.lead_owner)
    if @lead.save
      redirect_to lead_path @lead, flash[:notice] = 'New Lead Created'
    else
      render :new
    end
  end
  
  def index
    @leads = Lead.all
  end
  
  def show
    @lead = Lead.find params[:id]
    @lead_owner     = User.all.map(&:email)
    @lead_status    = Lead.status
    @lead_sources   = Lead.sources
    @lead_interests = Lead.interests
  end
  
  def edit
  end
  
  def update
    @lead = Lead.find params[:id]
    if params[:commit] == 'Convert'
      binding.pry
      @contacts = Contact.all.map(&:email)

    else  
      if @lead.update_attributes params[:lead]
        redirect_to lead_path @lead, flash[:notice] = 'Lead Updated'
      else
        render :edit
      end
    end
  end
  
  def destroy
    @lead = Lead.find params[:id]
    
    if @lead.destroy
      flash[:notice] = 'Lead Deleted'
      redirect_to :back
    else
      flash[:error] = 'Lead could not be deleted'
      redirect_to :back
    end
  end

  def convert
    @lead = Lead.find params[:id]
    @accounts = Account.all.map(&:name)
  end

end
