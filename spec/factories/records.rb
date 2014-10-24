# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :record do
    audio_url "MyString"
    audio_length "MyString"
    question nil
    user nil
  end
end
