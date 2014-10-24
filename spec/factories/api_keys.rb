# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api_key do
    access_token "MyString"
    expires_at "2014-10-15 13:33:43"
    user nil
    active false
  end
end
