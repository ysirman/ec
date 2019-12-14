# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    association :user
    sequence(:name)  { |n| "something nice#{n}" }
    price   { 100 }
    on_sale { true }
  end
end
