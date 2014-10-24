# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    login "MyString"
    email "MyString"
    password "MyString"
  end
end
