# require the gems
%w(sinatra 
   haml 
   dm-core
   dm-migrations 
   dm-constraints 
   carrierwave 
   carrierwave/datamapper 
   fog).each  { |gem| require gem}

# setup DataMapper
DataMapper.setup(:default, 'postgres://<USERNAME>:<PASSWORD>@localhost:5432/pdfs')
DataMapper::Model.raise_on_save_failure = true

# require the models
%w(pdf image).each {|model| require "./#{model}"}

# finalize DataMapper
DataMapper.finalize

# configure CarrierWave
CarrierWave.configure do |config|
 config.permissions = 0666
 config.storage = :fog
 config.fog_credentials = {
   :provider               => 'AWS',    
   :aws_access_key_id      => <AWS_ACCESS_KEY>,  
   :aws_secret_access_key  => <AWS_SECRET_ACCESS_KEY>
 }
 config.root = "public/"
 config.fog_directory  = <AWS BUCKET>
 config.fog_public = true
 config.cache_dir = '/tmp/upload' 
end   