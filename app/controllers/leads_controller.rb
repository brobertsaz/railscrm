class LeadsController < ApplicationController
  before_filter :authenticate_user!, :except => ['external_form']
  
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
      LeadMailer.notify_new_lead(@lead.lead_owner, @lead).deliver
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
        LeadMailer.notify_updated_lead(@lead.lead_owner, @lead).deliver
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

  def new_web_lead
    leads = Lead.new
    minus_lead = ["_type","_id","created_at", "updated_at", "lead_source", "lead_status","lead_owner", "account_name","opportunity_name","opportunity_owner","assigned_to_id"]
    lead = leads.attribute_names.to_a
    @lead = lead-minus_lead
  end

  def create_web_lead
    @in_lead = []
    default_url = "http://demo.railscrm.com" #CHANGE THIS TO A VALID URL
    default_fields = ["first_name","last_name", "email", "company", "phone"]
    # @params = params[:lead].split(' ')
    # @params.each do |param|
    #   if params["#{param}"].to_i == 1
    #     @in_lead << param
    #   end
    # end
    @redirect_url = params[:redirect_url]
    if @in_lead.empty?
      @in_lead = default_fields
    end
    @value=""
    @required="required"
    @lead_owner = encrypt(current_user.email)
    @redirect_url = params[:redirect_url].empty? ? default_url : params[:redirect_url]
    render "web_form"
  end

  def external_form
    email = decrypt(params[:lead_owner])
    user = User.where(:email =>email).first
    requestor = "#{request.protocol}#{request.fullpath}"
    if user.nil?
      redirect_to requestor
    else
      redirect_url = params[:redirect_url]
      leads = params[:params].split(" ")
      @lead = Lead.new
      leads.each do |lead|
        @lead.update_attribute("#{lead}", params["#{lead}"])
      end
      @lead.update_attributes(:lead_owner => email,:lead_source => requestor)
      if @lead.save!
        redirect_to redirect_url
      end
    end
  end

  private
    def encrypt(data)
      return encrypted_data = KEY.enc(data)
    end

    def decrypt(encrypted_data)
      return data = KEY.dec(encrypted_data)
    end
end  