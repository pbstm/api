class AvatarUploader < BaseUploader
  def size_range
    0..1.megabytes
  end

  process resize_to_fit: [ 300, 300 ]
end
