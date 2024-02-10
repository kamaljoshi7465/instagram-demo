class Comment < ApplicationRecord
  belongs_to :post
  validates :body, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["post"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "post_id", "updated_at"]
  end
end
