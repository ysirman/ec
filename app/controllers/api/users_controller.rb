# frozen_string_literal: true

class Api::UsersController < ApplicationController
  skip_before_action :authenticate, only: :create
  before_action :set_user, only: [:show]

  def index
    users = User.order(created_at: :desc)
    render json: { status: "SUCCESS", message: "Loaded users", data: users }
  end

  def show
    render json: { status: "SUCCESS", message: "Loaded the user", data: @user }
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { status: "SUCCESS", data: user }
    else
      render json: { status: "ERROR", data: user.errors }
    end
  end

  def destroy
    @current_user.destroy
    render json: { status: "SUCCESS", message: "Deleted current user", data: @current_user }
  end

  def update
    if @current_user.update(user_params)
      render json: { status: "SUCCESS", message: "Updated current user", data: @current_user }
    else
      render json: { status: "ERROR", message: "Not updated", data: @current_user.errors }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :email,
        :password,
        :point)
    end
end
