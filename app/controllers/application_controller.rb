# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  private
    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        User.find_by(token: token).present? && current_user(token)
      end
    end

    def current_user(token)
      @current_user = User.find_by(token: token)
    end
end
