FactoryBot.define do
  factory :user do
    nickname {Faker::Artist.name}
    email {Faker::Internet.free_email}
    password = "1a" + Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    first_name {"山田"}
    last_name {"太郎"}
    first_name_kana {"ヤマダ"}
    last_name_kana {"タロウ"}
    birthday {Faker::Date.in_date_period}
  end
end
