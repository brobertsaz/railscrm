class Contact

  include Mongoid::Document
  include Mongoid::Timestamps
 
  field :first_name
  field :last_name
  field :company
  field :email  
  field :phone   
  field :address
  field :city
  field :state
  field :zip 
 
  validates :email, uniqueness: true,
                    format: { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, 
                    message: 'Invalid e-mail address' }
  validates_presence_of :first_name, :last_name, :email


  def full_name
    if self.last_name != nil
      self.first_name + " " + self.last_name
    elsif
      self.first_name
    end
  end

end
