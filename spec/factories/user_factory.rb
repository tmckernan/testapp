FactoryGirl.define do
  factory :user do
    email FFaker::Internet.email
    password "password12"
  end
end
