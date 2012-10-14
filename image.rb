class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :fog
      
  def filename
    "img_#{model.pdf.original_filename}_#{model.seq}.png" if original_filename
  end


end

class Image
  include DataMapper::Resource

  property :id, Serial
  property :seq, Integer
  mount_uploader :uploaded, ImageUploader, :required => true
  belongs_to :pdf
  
end