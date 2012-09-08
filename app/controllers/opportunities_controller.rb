class OpportunitiesController < ApplicationController

	def new
		@opportunity 						= Opportunity.new
		@opportunity_owner  	  = User.all.map(&:email)
    @opportunity_type		   	= Opportunity.types
    @opportunity_stage  		= Opportunity.stages
    @opportunity_account		= Account.all.map(&:name)
	end



	
end
