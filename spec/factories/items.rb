FactoryBot.define do
  factory :item do

    Faker::Config.locale = :ja
    
    item_name             { Faker::Lorem.sentence(word_count: 15) }
    description           { Faker::Lorem.paragraph }
    category_id           { Faker::Number.between(from:1, to: 11) }
    condition_id          { Faker::Number.between(from:1, to: 7) }
    fee_option_id         { Faker::Number.between(from:1, to: 3) }
    region_id             { Faker::Number.between(from:1, to: 48) }
    delivery_d_id         { Faker::Number.between(from:1, to: 4) }
    price                 { Faker::Number.between(from:300, to: 9_999_999) }

    association :user

    after(:build) do |message|
      message.item_image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    
  end
end
