class User < ApplicationRecord
  has_secure_password
  before_validation :set_username, on: :create

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "password_digest", "updated_at", "username"]
  end

  private

  def set_username
    self.username ||= email.split('@').first + rand(1000).to_s
  end
end
