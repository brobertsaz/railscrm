class Note
  include Mongoid::Document
  
  field :content
  
  belongs_to :lead
end
