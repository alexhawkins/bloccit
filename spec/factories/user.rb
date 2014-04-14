FactoryGirl.define do
  factory :user do
    name "Douglas Adams"
    #This will generate a unique email for each person, 
    #which is great because Devise has a validation to 
    #check email uniqueness.
    sequence(:email) { |n| "person#{n}@example.com" }
    email "douglas@example.com"
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
  end
end