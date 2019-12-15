# frozen_string_literal: true

require "rails_helper"

RSpec.describe "LoginAPI" do
  it "get token" do
    user = FactoryBot.create(:user)
    post "/api/login", params: { login: { email: user.email, password: user.password } }
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json["token"]).not_to eq(nil)
  end
end
