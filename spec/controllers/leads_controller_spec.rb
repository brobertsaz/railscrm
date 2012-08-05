require 'spec_helper'

describe LeadsController do

  describe 'update' do
    
    it 'should update a lead' do
      pending "Need to fix later"
      lead = Lead.create
      lead.notes << Note.create(:note_content => 'asdf')
      put :update, :id => lead.id, :lead => lead.attributes
      assigns(:lead).notes[0].note_content.should == 'asdf'
    end

  end

end
