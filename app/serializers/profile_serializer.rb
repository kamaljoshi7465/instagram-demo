class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :website, :bio, :profile_photo_url, :post_count, :followers, :following
  
  def profile_photo_url
    if object.photo&.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.photo)
    end
  end
  def post_count
    object.user.posts&.count
  end
  def followers
    nil
  end
  def following
    nil
  end
end