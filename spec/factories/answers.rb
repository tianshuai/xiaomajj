# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    tip "MyText"
    audio_url "MyString"
    audio_length "MyString"
    question nil
  end
end
