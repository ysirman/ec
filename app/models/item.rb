# frozen_string_literal: true

class Item < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true

  belongs_to :user
  has_one :order_history
  has_one :ordered_user, through: :orders, source: :user
end
