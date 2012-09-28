# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name             'Test'
    last_name			   'User'
    email                  'test@example.com' 
    phone				   '8005551212'
    password               'password'
    password_confirmation  'password'
  end
end
