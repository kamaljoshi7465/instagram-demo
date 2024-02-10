ActiveAdmin.register Post do
  permit_params :desc, :user_id, photos: []

  index do
    selectable_column
    id_column
    column :desc
    column :user_id
    actions
  end

  form do |f|
    f.inputs do
      f.input :desc
      f.input :user, as: :select, collection: User.includes(:profile).map { |user| [user.profile&.name, user.id] }, include_blank: false
      f.input :photos, as: :file, input_html: { multiple: true, accept: 'image/*' }
    end
    f.actions
  end

  show do |post|
    attributes_table do
      row :desc
      row :user_id
      row :photos do |post|
        div style: "display: flex; flex-wrap: wrap;" do
          post.photos.each do |photo|
            div style: "margin-right: 10px; margin-bottom: 10px;" do
              image_tag url_for(photo), size: '150x150'
            end
          end
        end
      end
    end
  end
end
