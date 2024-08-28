# app/uploaders/avatar_uploader.rb
class AvatarUploader < CarrierWave::Uploader::Base
    # Your configuration here
    storage :file

    # Define the directory where uploaded files will be stored
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  
    # Add a white list of extensions which are allowed to be uploaded
    def extension_whitelist
      %w[jpg jpeg gif png]
    end
end
  