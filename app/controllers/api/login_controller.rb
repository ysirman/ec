# frozen_string_literal: true

class Api::LoginController < ApplicationController
  skip_before_action :authenticate

  def login
    user = User.find_by(email: login_params[:email])
    if user&.authenticate(login_params[:password])
      render json: { status: "SUCCESS", message: "login success", token: user.token }
    else
      render json: { status: "ERROR", message: "login error" }
    end
  end

  private
    def login_params
      params.require(:login).permit(:email, :password)
    end
end
