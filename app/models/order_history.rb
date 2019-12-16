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
        item.lock!.update!(on_sale: false)                # itemを悲観的ロックして、on_saleを更新（販売中:true => 売切:false）
        order_history.save!                               # 購入履歴作成
        user.update!(point: user.point - item.price)      # 購入者のpointを価格分マイナス
        exhibitor.update!(point: user.point + item.price) # 出品者のpointを価格分プラス
      end
      true
    end
  end

  private
    class << self
      def order_check(order_history)
        check_user_point(order_history)  # point不足の場合、購入不可
      end

      def check_user_point(order_history)
        (order_history.user.point - order_history.item.price) < 0 ? false : true
      end
    end
end
