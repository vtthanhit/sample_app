class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, format: {with: VALID_EMAIL_REGEX}, presence: true,
  uniqueness: {case_sensitive: false}
  validates :password, presence: true
  validates :password, length: {in: Settings.length_8..Settings.length_20}
  validates :name, presence: true
  has_secure_password
end
