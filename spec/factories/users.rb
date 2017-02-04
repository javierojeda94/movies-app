FactoryGirl.define do
  factory :user do
    email 't1@test.com'
    password 'Pa$$w0rd'
    password_confirmation 'Pa$$w0rd'
  end
end