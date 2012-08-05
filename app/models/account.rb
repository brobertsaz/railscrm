class Account
  include Mongoid::Document

  field :name
  field :assigned_to
  field :phone
  field :website
  field :email
  field :address
end
