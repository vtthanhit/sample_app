class User < ApplicationRecord
  attr_accessor :remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, format: {with: VALID_EMAIL_REGEX}, presence: true,
  uniqueness: {case_sensitive: false}
  validates :password, presence: true
  validates :password, length: {in: Settings.length_8..Settings.length_20}
  validates :name, presence: true
  has_secure_password

  class << self
    def digest string
      cost = BCrypt::Engine::DEFAULT_COST
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_column :remember_digest, nil
  end
end
