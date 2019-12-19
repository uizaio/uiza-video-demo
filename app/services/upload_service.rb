class UploadService
  def create(name, file_local_path)
    upload = Upload.create(name: name, file_local_path: file_local_path)
    [true, upload, 200]
  end

  def progress(upload_code, upload_data)
    upload = Upload.find_by_code(upload_code).first
    if upload.blank?
      return [false, ['Upload object not found'], 400]
    else
      upload.update(status: 1)
      [true, upload, 200]
    end
  end
end