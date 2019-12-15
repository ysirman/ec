# frozen_string_literal: true

class Api::OrderHistoriesController < ApplicationController
  before_action :set_order_history, only: [:show]
  before_action :correct_user, only: [:show]

  def index
    order_histories = OrderHistory.where(user_id: @current_user.id).order(created_at: :desc)
    if order_histories
      render json: { status: "SUCCESS", message: "Loaded your order histories", data: order_histories }
    else
      render json: { status: "ERROR", message: "No data" }
    end
  end

  def show
    order_history_data = { order_history: @order_history,
                                    item: @order_history.item }
    render json: { status: "SUCCESS", message: "Loaded the order histories", data: order_history_data }
  end

  def create
    order_history = OrderHistory.new(order_history_params)
    order_history.user_id = @current_user.id
    if OrderHistory.check_and_create(order_history)
      order_history_data = { order_history: order_history,
                                      item: order_history.item,
                                      user: order_history.user }
      render json: { status: "SUCCESS", data: order_history_data }
    else
      render json: { status: "ERROR", message: "Something wrong" }
    end
  end

  private
    def set_order_history
      @order_history = OrderHistory.find(params[:id])
    end

    def order_history_params
      params.require(:order_history).permit(:item_id)
    end

    def correct_user
      @order_history = @current_user.order_histories.find_by(id: params[:id])
      render json: { status: "ERROR", message: "Not yours" } if @order_history.nil?
    end
end
