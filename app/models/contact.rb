class Contact

  include Mongoid::Document
  include Mongoid::Timestamps
 
  field :first_name,  type: String
  field :last_name,   type: String
  field :company,     type: String
  field :email,       type: String
  field :phone,       type: String
  field :address,     type: String
  
  validates :email, uniqueness: true
  validates_presence_of :first_name, :last_name, :email
    

  #doing some tacky patchwork to merge user as a subclass to contact [somewhat] seamlessly
  #since users dont have a last_name (but other sub classes do), 
  #I will have this method just print their first name when they don't have a last on file.
  def full_name
    if self.last_name != nil
      self.first_name + " " + self.last_name
    elsif
      self.first_name
    end
  end

end
