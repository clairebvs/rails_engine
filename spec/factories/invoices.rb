FactoryBot.define do
  factory :invoice do
    customer { nil }
    merchant { "" }
    status { "MyString" }
  end
end
