ActiveAdmin.register Profile do
  actions :all, except: [:new]
  permit_params :name, :username, :photo, :bio, :website, :user_id

  index do
    selectable_column
    id_column
    column :name
    column :username
    column :photo do |post|
      if post.photo.attached?
        image_tag url_for(post.photo), size: '30x30'
      else
        "No photo attached"
      end
    end
    column :bio
    column :website
    actions
  end

  show do |post|
    attributes_table do
      row :name
      row :user_name
      row :bio 
      row :website
      row :photo do |post|
        if post.photo.attached?
          image_tag url_for(post.photo), size: '200x150'
        else
          "No photo attached"
        end
      end
    end
  end
  
  filter :name
  filter :created_at
end
