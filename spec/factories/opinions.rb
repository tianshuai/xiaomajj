# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :opinion do
    content "MyString"
    user nil
  end
end
