# frozen_string_literal: true

class AddIndexCreatedAtToItemAndOrderHistory < ActiveRecord::Migration[5.2]
  def change
    # 負荷対策（毎回ソートされるのを回避する）
    add_index :items, :created_at
    add_index :order_histories, :created_at
  end
end
