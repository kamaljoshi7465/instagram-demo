class Post < ApplicationRecord
  has_many_attached :photos

  belongs_to :user
  has_many :comments, dependent: :destroy

  def self.ransackable_associations(auth_object = nil)
    ["comments", "photos_attachments", "photos_blobs", "user"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "desc", "id", "updated_at", "user_id"]
  end
end
