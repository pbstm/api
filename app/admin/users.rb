ActiveAdmin.register User do
  permit_params :name, :email, :type, :avatar

  scope 'Customers', :customer
  scope 'Photographers', :photographer

  index do
    id_column
    column :name
    column :email
    column :type
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :type, as: :select, collection: %w[Customer Photographer].freeze
      f.input :avatar
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :type
      row :created_at
      row :updated_at
      row( :avatar ) { |user| user.avatar.present? ? image_tag( user.avatar.url, size: '300x300' ) : nil }
    end
  end
end
