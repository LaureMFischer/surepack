FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    password 'swordfish'
  end

  factory :list do
    user
    name { Faker::Lorem.word }
    deadline_date '2014-05-25'
    deadline_time '2:00:00PM'
  end
end
