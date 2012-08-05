# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lead do
  	first_name             'Ima'
    last_name							 'Lead'
    email                  'lead@example.com' 
    phone									 '8005551212'
   end
end