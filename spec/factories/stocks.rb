FactoryGirl.define do
  factory :stock do
    code {Faker::Lorem.word}
    name {Faker::Lorem.word}
    highest {Faker::Number.between(300, 400)}
    lowest {Faker::Number.between(100, 200)}
    current {Faker::Number.between(200, 300)}
    difference {Faker::Number.between(-10, 10)}
  end
end
