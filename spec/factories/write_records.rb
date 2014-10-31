# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :write_record, :class => 'WriteRecords' do
    content "MyText"
  end
end
