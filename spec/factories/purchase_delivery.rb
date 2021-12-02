FactoryBot.define do
  factory :purchase_delivery do
    token { 'tok_000000000000000000000000000000' }
    post_num { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { '神戸市中央区' }
    address { '元町1-2-3' }
    building { '小籠包食べたい１F' }
    phone { Faker::Number.leading_zero_number(digits: 11) }
  end
end
