class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{ model.class.to_s.underscore }/#{ mounted_as }/#{ model.id }"
  end

  def size_range
    0..10.megabytes
  end

  def filename
    "#{ sha1 file }.#{ file.extension }" if original_filename.present?
  end

  def asset_host
    ENV[ 'APP_HOST' ] || 'http://localhost:3000'
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  private

  def sha1( file )
    Digest::SHA1.hexdigest file.read
  end
end
