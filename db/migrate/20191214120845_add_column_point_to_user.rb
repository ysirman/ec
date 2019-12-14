# frozen_string_literal: true

class AddColumnPointToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :point, :integer, null: false, default: 10000
  end
end
