# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :token, null: false

      t.timestamps
    end
    add_index :users, :token, unique: true
  end
end
