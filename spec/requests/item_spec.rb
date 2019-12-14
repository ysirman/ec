# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ItemAPI" do
  before(:each) do
    @user = FactoryBot.create(:user)
    @token = { "Authorization" => "Token token=#{@user.token}" }
  end

  it "get all items" do
    FactoryBot.create_list(:item, 10)
    get "/api/items", headers: @token
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json["data"].length).to eq(10)
  end

  it "get the item" do
    item = FactoryBot.create(:item)
    get "/api/items/#{item.id}", headers: @token
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json["data"]["name"]).to eq(item.name)
  end

  it "create item" do
    item_params = { params:
                      { item:
                        { name: "good item", price: 300 } },
                    headers: @token }
    expect {
      post "/api/items", item_params
    }.to change(Item, :count).by(1)
    expect(response.status).to eq(200)
  end

  it "update item" do
    item = FactoryBot.create(:item, user_id: @user.id)
    item_params = { params:
                      { item: { name: "other item" } },
                    headers: @token }
    put "/api/items/#{item.id}", item_params
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json["data"]["name"]).to eq("other item")
  end

  it "delete item" do
    item = FactoryBot.create(:item, user_id: @user.id)
    expect {
      delete "/api/items/#{item.id}", headers: @token
    }.to change(Item, :count).by(-1)
    expect(response.status).to eq(200)
  end
end
