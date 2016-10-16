FactoryGirl.define do
  factory :recipient do
    name FFaker::Name.name
    recipient_id FFaker::Identification.ssn
    user
  end
end
