FactoryGirl.define do
  factory :user do
    email "lauren@lauren.com"
    password_digest "password"

    factory :user_with_links do
      links {create_list(:link, 3)}
    end
  end
end
