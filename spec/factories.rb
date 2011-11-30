FactoryGirl.define do
  
  factory :user do
    name {Faker::Name.name}
    sequence(:email) { |n| "#{n}" + Faker::Internet.email }
    admin false
  end
  
  factory :admin, :class => User do
    name {"(A) " + Faker::Name.name}
    sequence(:email) { |n| "#{n}" + Faker::Internet.email }
    admin true
  end
  
  factory :division, :class => Division do
    sequence(:dex) { |n| n }
    title { Faker::Lorem.words(3).join(" ") }
  end
  
  factory :forum, :class => Forum do
    sequence(:dex) { |n| n }
    title {Faker::Company.name}
  end
  
  factory :topic, :class => Topic do
    title {Faker::Company.bs}
  end
  
  factory :post, :class => Post do
    content {Faker::Company.catch_phrase + ". " + Faker::Lorem.paragraphs(2).join(" ")}
  end
end