# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:id)     { |n| n }
    sequence(:email)  { |n| "test#{n}@test.jp" }
    password          { "Password" }
    point             { 10000 }
  end
end
