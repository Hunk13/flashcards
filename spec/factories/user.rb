FactoryGirl.define do
  factory :user do
    name "Vasya Pupkin"
    email "mail@mail.com"
    password "12345"
    password_confirmation { password }
  end
end