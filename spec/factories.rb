FactoryGirl.define do
  
  factory :user do
    name  'David'
    email 'davidmann10k@gmail.com'
    admin false
  end
  
  factory :admin, :class => User do
    name  'David'
    email 'davidmann10k@gmail.com'
    admin true
  end
end