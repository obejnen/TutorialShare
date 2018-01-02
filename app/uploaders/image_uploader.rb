class ImageUploader < CarrierWave::Uploader::Base


  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  version :small do
    process resize_to_fit: [70, 70]
  end

  version :medium do
    process resize_to_fit: [200, 200]
  end
  
  version :large do
    process resize_to_fit: [600, 600]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
