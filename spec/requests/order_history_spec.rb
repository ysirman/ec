# frozen_string_literal: true

require "rails_helper"

RSpec.describe "OrderHistoryAPI" do
  before(:each) do
    @user = FactoryBot.create(:user)
    @token = { "Authorization" => "Token token=#{@user.token}" }
  end

  it "get all order histories of current_user" do
    FactoryBot.create_list(:order_history, 10, user_id: @user.id)
    get "/api/order_histories", headers: @token
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json["data"].length).to eq(10)
  end

  it "get the order history" do
    order_history = FactoryBot.create(:order_history, user_id: @user.id)
    get "/api/order_histories/#{order_history.id}", headers: @token
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json["data"]["order_history"]["user_id"]).to eq(@user.id)
  end

  it "create order history and update user and item" do
    item = FactoryBot.create(:item)
    current_point = @user.point
    order_history_params = { params:
                              { order_history: { user_id: @user.id, item_id: item.id } },
                            headers: @token }
    expect {
      post "/api/order_histories", order_history_params
    }.to change(OrderHistory, :count).by(1)
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json["data"]["item"]["on_sale"]).to eq(false)
    expect(json["data"]["user"]["point"]).to eq(current_point - item.price)
  end
end
