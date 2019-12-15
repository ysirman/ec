# frozen_string_literal: true

class OrderHistory < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates :user_id, presence: true
  validates :item_id, presence: true

  def self.check_and_create(order_history)
    if self.order_check(order_history)
      item = order_history.item
      user = order_history.user
      exhibitor = order_history.item.user
      self.transaction do
        item.lock!.update!(on_sale: false)
        order_history.save!
        user.update!(point: user.point - item.price)
        exhibitor.update!(point: user.point + item.price)
      end
      true
    end
  end

  private
    class << self
      def order_check(order_history)
        check_user_point(order_history)
      end

      def check_user_point(order_history)
        if (order_history.user.point - order_history.item.price) < 0
          false
        else
          true
        end
      end
    end
end
