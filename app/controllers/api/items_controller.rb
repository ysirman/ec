# frozen_string_literal: true

class Api::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :correct_user, only: [:update, :destroy]

  def index
    items = Item.order(created_at: :desc)
    render json: { status: "SUCCESS", message: "Loaded items", data: items }
  end

  def show
    render json: { status: "SUCCESS", message: "Loaded the item", data: @item }
  end

  def create
    item = Item.new(item_params)
    item.user_id = @current_user.id
    if item.save
      render json: { status: "SUCCESS", data: item }
    else
      render json: { status: "ERROR", data: item.errors }
    end
  end

  def destroy
    @item.destroy
    render json: { status: "SUCCESS", message: "Deleted current item", data: @item }
  end

  def update
    if @item.update(item_params)
      render json: { status: "SUCCESS", message: "Updated current item", data: @item }
    else
      render json: { status: "ERROR", message: "Not updated", data: @item.errors }
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(
        :name,
        :price,
        :on_sale)
    end

    def correct_user
      @item = @current_user.items.find_by(id: params[:id])
      render json: { status: "ERROR", message: "Not yours" } if @item.nil?
    end
end
