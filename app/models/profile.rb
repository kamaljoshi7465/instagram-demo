class Profile < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  before_validation :set_username, on: :create

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  def self.ransackable_associations(auth_object = nil)
    ["photo_attachment", "photo_blob", "user"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["bio", "created_at", "id", "name", "photo", "updated_at", "user_id", "username", "website"]
  end

  private

  def set_username
    self.username ||= self.user.email.split('@').first + rand(1000).to_s
  end
end
