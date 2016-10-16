FactoryGirl.define do
  factory :account do
    user
    api_key FFaker::Identification.ssn
    username FFaker::Name.first_name
  end
end
