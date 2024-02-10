ActiveAdmin.register Comment, :as => 'PostComment' do
  permit_params :body, :post_id
end
