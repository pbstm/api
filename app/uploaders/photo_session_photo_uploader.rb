class PhotoSessionPhotoUploader < BaseUploader
  def size_range
    0..1.megabytes
  end
end
