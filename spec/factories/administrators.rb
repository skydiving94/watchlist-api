FactoryGirl.define do
  factory :administrator do
    name {Faker::Name.name}
    email 'foo@bar.com'
    password 'foobar'
  end
end
