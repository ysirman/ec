# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with a email, and password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is invalid without an email address" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include(I18n.t :"errors.messages.blank")
  end

  it "is invalid without a password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include(I18n.t :"errors.messages.blank")
  end
end
