class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_one :profile

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, presence: true, on: :create

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "password_digest", "updated_at"]
  end
end
