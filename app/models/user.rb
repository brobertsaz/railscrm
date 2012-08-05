require 'digest/sha2'

class User < Contact
  include Mongoid::Document
  include Mongoid::Timestamps
  include OmniAuth::Identity::Models::Mongoid

  field :password_digest, type: String
  field :token
  
  has_many :leads
  
  def reset_password
    self.create_token
    UserMailer.reset_password(self).deliver
  end
  
  def create_token
    self.update_attribute token, User.generate_token
  end
  
  def self.generate_token
    Digest::SHA256.hexdigest(Time.now.to_s)
  end

  
end
