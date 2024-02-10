class PostSerializer < ActiveModel::Serializer
  attributes :id, :desc, :photo_url

  def photo_url
    if object.photos.attached?
      object.photos.map { |image|
        {
          id: image.id,
          url: Rails.application.routes.url_helpers.rails_blob_url(image, only_path: false)
        }
      }
    end
  end
end