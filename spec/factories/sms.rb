# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sm, :class => 'Sms' do
    incoming_number "MyString"
    content_received "MyString"
  end
end
