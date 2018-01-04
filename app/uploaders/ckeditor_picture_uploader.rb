# encoding: utf-8
class CkeditorPictureUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  process :extract_dimensions

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fill: [118, 100]
  end

  version :content do
    process resize_to_limit: [800, 800]
  end



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


  def extension_white_list
    Ckeditor.image_file_types
  end
end
