FactoryGirl.define do
  factory :payment do
    currency FFaker::Currency.code
    payment_id FFaker::Identification.ssn
    amount 10
    recipient
  end
end
