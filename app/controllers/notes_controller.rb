class NotesController < ApplicationController
  def create
    @lead = Lead.find(params[:lead_id])
    @note = @lead.notes.create(params[:note])
    redirect_to @lead
  end
end
