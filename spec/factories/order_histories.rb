# frozen_string_literal: true

FactoryBot.define do
  factory :order_history do
    association :user
    association :item
    sequence(:id) { |n| n }
    created_at    { Time.now }
    updated_at    { Time.now }
  end
end
