# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.boolean :on_sale, null: false, default: true
      t.integer :user_id

      t.timestamps
    end
    add_index :items, :user_id
  end
end
