class Lead < Contact  
  field :interested_in
  field :comments
  field :lead_status
  field :lead_source
  field :lead_owner

  belongs_to :assigned_to, class_name: 'User'
  embeds_many :notes
  accepts_nested_attributes_for :notes, allow_destroy: true
  validates_presence_of :lead_owner

  STATUS      = [['New', 'new'], ['Contacted', 'contacted'], ['Qualified', 'qualified'], ['Disqualified', 'disqualified']]
  SOURCES     = [['Web Lead', 'web'], ['Phone', 'phone'], ['Referral', 'referral'], ['Conference', 'conference']]
  INTERESTS   = [['Web Application', 'web_app'], ['IOS', 'ios']]

  class << self
    
    def status
      STATUS
    end
    
    def sources
      SOURCES
    end

    def interests
      INTERESTS
    end
    
  end
  
  
end
