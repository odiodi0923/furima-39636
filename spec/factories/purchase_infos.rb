FactoryBot.define do
  factory :purchase_info do
    Faker::Config.locale = :ja

    postal_code { '123-1247' }
    region_id { Faker::Number.between(from: 2, to: 48) }
    city { Faker::Lorem.sentence(word_count: 15) }
    street_num { Faker::Lorem.sentence(word_count: 15) }
    building { Faker::Lorem.sentence(word_count: 15) }
    phone { Faker::Number.number(digits: 11) }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
