FactoryBot.define do
  factory :user do
    japanese_user = Gimei.name

    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.unique.email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name            { japanese_user.first.kanji }
    first_name_kana       { japanese_user.first.katakana }
    last_name             { japanese_user.last.kanji }
    last_name_kana        { japanese_user.last.katakana }
    birth_date            { Faker::Date.between(from: '1930-01-01', to: '2018-12-31') }
  end
end
