FactoryGirl.define do
  value = Faker::Number.between(0, 100)
  factory :stock do
    code {Faker::Lorem.word}
    name {Faker::Lorem.word}
    highest {value}
    lowest {value}
    current {value}
    difference {0}
  end
end
