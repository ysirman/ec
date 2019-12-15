# frozen_string_literal: true

class CreateOrderHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :order_histories do |t|
      t.integer :user_id
      t.integer :item_id

      t.timestamps
    end
    add_index :order_histories, :user_id
    add_index :order_histories, :item_id, unique: true
    add_index :order_histories, [:user_id, :item_id], unique: true
  end
end
