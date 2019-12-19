class UploadService
  def create(name, upload_data)
    begin
      upload = Upload.create(name: name, status: 1)
      [true, upload, 200]
    rescue Exception => e
      [false, e.errors, 422]
    end
  end

  # def progress(upload_code, upload_data)
  #   upload = Upload.find_by_code(upload_code).first
  #   if upload.blank?
  #     return [false, ['Upload object not found'], 400]
  #   else
  #     upload.update(status: 1)
  #     [true, upload, 200]
  #   end
  # end
end