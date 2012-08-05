class Note
  include Mongoid::Document
  
  field :content
  
  embedded_in :lead
end
