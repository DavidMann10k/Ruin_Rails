FactoryGirl.define do
        
  factory :user do
    sequence(:name) { |n| "user #{n}" }
    sequence(:email) { |n| "user#{n}@email.com" }
    admin false
  end
  
  factory :admin, :class => User do
    sequence(:name) {|n| "Admin User #{n}" }
    sequence(:email) {|n| "admin#{n}@user.com" }
    admin true
  end
end