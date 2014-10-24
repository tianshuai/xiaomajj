# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    month "MyString"
    number "MyString"
    title "MyString"
    content "MyString"
    video_url "MyString"
  end
end
