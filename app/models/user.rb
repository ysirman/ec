# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_token
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
