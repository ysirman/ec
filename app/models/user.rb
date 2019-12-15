# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_token
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, allow_nil: true

  has_many :items
  has_many :order_histories
  has_many :order_items, through: :orders, source: :item
end
