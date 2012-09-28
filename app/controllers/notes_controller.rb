class NotesController < ApplicationController
  
  def new
    @lead = Lead.new
    redirect_to :back
  end


  def create
    @lead = Lead.find(params[:lead_id])
    @note = @lead.notes.create(params[:note])
    redirect_to @lead
  end
end
