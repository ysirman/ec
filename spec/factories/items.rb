# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    association :user
    sequence(:id)    { |n| n }
    sequence(:name)  { |n| "something nice#{n}" }
    price            { 100 }
    on_sale          { true }
    created_at       { Time.now }
    updated_at       { Time.now }
  end
end
