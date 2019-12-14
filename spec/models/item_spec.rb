# frozen_string_literal: true

require "rails_helper"

RSpec.describe Item, type: :model do
  it "is valid with a name, price and user_id" do
    item = FactoryBot.build(:item)
    expect(item).to be_valid
  end

  it "is invalid without a name" do
    item = FactoryBot.build(:item, name: nil)
    item.valid?
    expect(item.errors[:name]).to include(I18n.t :"errors.messages.blank")
  end

  it "is invalid without a price" do
    item = FactoryBot.build(:item, price: nil)
    item.valid?
    expect(item.errors[:price]).to include(I18n.t :"errors.messages.blank")
  end

  it "is invalid without a user_id" do
    item = FactoryBot.build(:item, user_id: nil)
    item.valid?
    expect(item.errors[:user]).to include(I18n.t :"errors.messages.required")
  end
end
