ActiveAdmin.register User do
  permit_params :name, :email, :username, :password
  
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :username
    actions
  end

  filter :name
  filter :email
  filter :username
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
    end
    f.actions
  end
end
