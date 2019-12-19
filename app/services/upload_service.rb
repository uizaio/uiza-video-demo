class UploadService
  def create(file_local_path)
    upload = Upload.create(file_local_path: file_local_path)
    [true, upload]
  end

  def progress(upload_data)
    
  end
end