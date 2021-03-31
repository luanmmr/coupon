FactoryBot.define do
  factory :burnt_coupon do
    order_number { "MyString" }
    coupon { nil }
    code { "MyString" }
    datetime { "2021-03-30" }
  end
end
