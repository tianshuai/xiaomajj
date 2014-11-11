# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :third_api do
    uid "MyString"
    user_id 1
    access_token "MyString"
    expires_in 1
    kind 1
    refresh_token "MyString"
  end
end
