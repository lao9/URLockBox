FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      Faker::Internet.email("lauren#{n}")
    end
    password "password"

    factory :user_with_links do
      links {create_list(:link, 3)}
    end

    factory :user_with_a_link do
      links {create_list(:link, 1)}
    end

    factory :user_with_a_read_link do
      links {create_list(:link, 1, read: true)}
    end
  end
end
