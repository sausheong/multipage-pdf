class PDFUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :fog
  
  process :convert_to_files
      
  def filename
    "#{model.original_filename}.#{model.suffix}" if original_filename
  end
  
  def convert_to_files
    manipulate!(format: 'png') do |img, index|
      image = model.images.new seq: index
      temp = Tempfile.new("image")
      tmp_image = img.write("png:"+ temp.path)      
      image.uploaded = temp
      image.save
      tmp_image
    end
  end

end


class Pdf
  include DataMapper::Resource

  property :id, Serial
  property :title, String, :length => 255
  property :original_filename, String
  property :doc_type, String, :length => 255
  property :suffix, String  
  has n, :images, constraint: :destroy
  mount_uploader :uploaded, PDFUploader, :required => true
  
end