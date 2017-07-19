FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      Faker::Internet.email("lauren#{n}")
    end
    password "password"

    factory :user_with_links do
      links {create_list(:link, 3)}
    end
  end
end
