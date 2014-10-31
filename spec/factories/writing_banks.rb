# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :writing_bank, :class => 'WritingBanks' do
    title "MyString"
    content "MyText"
  end
end
