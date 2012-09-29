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
      convert_lead
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
    @lead               = Lead.find params[:id]
    @accounts           = Account.all.map(&:name)
    @opportunity_owner  = User.all.map(&:email)
  end

  def convert_lead
    @lead = Lead.find params[:id]
    @lead.update_attributes params['lead']
    @account = Account.where(name: params['account_name']).first
    @contacts = Contact.all.map(&:email)
    unless @contacts.include? @lead.email
      @contact = Contact.create params['lead']
    end
    @opportunities = Opportunity.all.map(&:opportunity_name)
    unless @opportunities.include? @lead.opportunity_name
      @opportunity = Opportunity.create(opportunity_name: @lead.opportunity_name, account_name: @lead.account_name, owner: @lead.opportunity_owner)
    end
    flash[:notice] = 'Lead has been converted'
    redirect_to opportunity_path(@opportunity)
  end

end  