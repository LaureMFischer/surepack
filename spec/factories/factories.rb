FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    password 'swordfish'
  end

end
