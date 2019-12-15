# frozen_string_literal: true

require "rails_helper"

RSpec.describe OrderHistory, type: :model do
  it "is valid with a item_id and user_id" do
    order_history = FactoryBot.build(:order_history)
    expect(order_history).to be_valid
  end

  it "is invalid without a item_id" do
    order_history = FactoryBot.build(:order_history, item_id: nil)
    order_history.valid?
    expect(order_history.errors[:item]).to include(I18n.t :"errors.messages.required")
  end

  it "is invalid without a user_id" do
    order_history = FactoryBot.build(:order_history, user_id: nil)
    order_history.valid?
    expect(order_history.errors[:user]).to include(I18n.t :"errors.messages.required")
  end
end
