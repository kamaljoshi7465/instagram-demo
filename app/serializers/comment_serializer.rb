class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :post_id, :user_profile, :user_name

  def user_name
    object.post.user&.profile&.username
  end

  def user_profile
    if object.post.user&.profile&.photo&.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.post.user.profile.photo, only_path: false)
    end
  end
end
