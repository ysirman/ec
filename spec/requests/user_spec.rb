# frozen_string_literal: true

require "rails_helper"

RSpec.describe "UserAPI" do
  before(:each) do
    @user = FactoryBot.create(:user)
    @token = { "Authorization" => "Token token=#{@user.token}" }
  end

  it "get current user" do
    get "/api/users", headers: @token
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json["data"]["email"]).to eq(@user.email)
  end

  it "create user" do
    user_params = { params:
                      { user:
                        { email: "test@test.jp", password: "password" } } }
    expect {
      post "/api/users", user_params
    }.to change(User, :count).by(1)
    expect(response.status).to eq(200)
  end

  it "update user" do
    user_params = { params:
                      { user: { email: "other@other.jp" } },
                    headers: @token }
    put "/api/users", user_params
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json["data"]["email"]).to eq("other@other.jp")
  end

  it "delete user" do
    expect {
      delete "/api/users", headers: @token
    }.to change(User, :count).by(-1)
    expect(response.status).to eq(200)
  end
end
