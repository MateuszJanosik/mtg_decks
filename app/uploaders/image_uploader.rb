class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :file

  version :thumb, from_version: :medium do
    process resize_to_fill: [105, 150]
  end

  version :medium do
    process resize_to_fill: [350, 500]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def default_url
    "/images/defaults/#{model.class.to_s.underscore}/" + [version_name, "default.jpg"].compact.join('_')
  end
end