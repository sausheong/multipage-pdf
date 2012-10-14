require './setup'

get "/" do
  haml :upload
end

post "/upload" do
  file = Pdf.create title: params[:title]  
  if params[:uploaded_file] && (tmpfile = params[:uploaded_file][:tempfile])
    file.original_filename, file.suffix = params[:uploaded_file][:filename].split(".")
    file.doc_type = params[:uploaded_file][:type]
    file.uploaded = tmpfile
  end  
  file.save  
  redirect "/"
end