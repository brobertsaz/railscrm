class OpportunitiesController < ApplicationController

	def new
		@opportunity 						= Opportunity.new
		@opportunity_owner  	  = User.all.map(&:email)
    @opportunity_type		   	= Opportunity.types
    @opportunity_stage  		= Opportunity.stages
    @opportunity_account		= Account.all.map(&:name)
	end

	def create
    @opportunity = Opportunity.new params[:opportunity]
    if @opportunity.save
      redirect_to opportunity_path @opportunity, flash[:notice] = 'New Opportunity Created'
    else
      render :new
    end
  end
  
  def index
    @opportunities = Opportunity.all
  end

  def show
		@opportunity 						= Opportunity.find params['id']
		@opportunity_owner  	  = User.all.map(&:email)
    @opportunity_type		   	= Opportunity.types
    @opportunity_stage  		= Opportunity.stages
    @opportunity_account		= Account.all.map(&:name)
	end

	def update
    @opportunity = Opportunity.find params[:id]

    if @opportunity.update_attributes params[:opportunity]
      redirect_to opportunity_path @opportunity, flash[:notice] = 'Opportunity Successfully Updated'
    else
      render :edit
    end
  end


  def destroy
    @opportunity = Opportunity.find params[:id]
    
    if @opportunity.destroy
      flash[:notice] = 'Opportunity Deleted'
      redirect_to :back
    else
      flash[:error] = 'Opportunity could not be deleted'
      redirect_to :back
    end
  end

end
