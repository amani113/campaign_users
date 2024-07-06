class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true,length: {minimum:3, maximum:20}
  validates :email, presence: true, uniqueness: true, format: {with: EMAIL_REGEX}
  validates :password,presence: true, length: {minimum:6}
  has_secure_password
end
