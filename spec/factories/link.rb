FactoryGirl.define do
  factory :link do
    title "Ruby Docs"
    url "http://ruby-doc.org/"
    read false
    user
  end
end
