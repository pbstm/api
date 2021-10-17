ActiveAdmin.register PhotoSession do
  permit_params :location_id, :title, :photographer_id, :description, :cover, photo_session_photos_attributes: %i[id _destroy photo]

  index do
    id_column
    column :title
    column :location
    column :photographer
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :location, as: :select, include_blank: false, collection: Location.pluck( :city, :id )
      f.input :photographer
      f.input :cover
      f.input :description
    end

    f.has_many :photo_session_photos, allow_destroy: true do |ff|
      ff.inputs 'Photos' do
        if ff.object.new_record?
          ff.input :photo
        else
          ff.input :photo, as: :file, hint: ff.template.image_tag( ff.object.photo.url, width: '100' )
        end
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row :title
      row :location
      row :photographer
      row :description
      row :created_at
      row( :cover ) { |photo_session| photo_session.cover.present? ? image_tag( photo_session.cover.url, width: '300' ) : nil }
    end

    panel 'Photos' do
      table_for photo_session.photo_session_photos do
        column( :photo ) { |photo_session_photo| image_tag photo_session_photo.photo.url, width: '500' }
      end
    end
  end
end
