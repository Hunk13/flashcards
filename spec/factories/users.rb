FactoryGirl.define do
  factory :user do
    email "mail@mail.com"
    crypted_password "$2a$10$/YcvCr39FAp2s6bRjhZxCOCkl1QauvUKITrdiNy/CzO..."
    salt "KVA1kJyPz4nBLC828xwp"
  end
end