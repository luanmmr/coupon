FactoryBot.define do
  factory :promotion do
    description { 'Natal da Locaweb' }
    prefix { "NATAL" }
    discount_percentage { 10.0 }
    max_discount_value { 50 }
    start_date { Date.current }
    end_date { 5.days.from_now }
    max_usage { 10 }
  end
end
