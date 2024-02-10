ActiveAdmin.register User do
  actions :all, except: [:new]
  permit_params :email, :password
  
  index do
    selectable_column
    id_column
    column :email
    column :username
    actions
  end

  filter :email
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
    end
    f.actions
  end
end
