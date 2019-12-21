class UploadService
  def create(name, upload_data)
    begin
      # Upload to S3 and get URL
      aws_s3_service = AwsS3Service.new(ENV['AWS_REGION'], ENV['AWS_BUCKET'])
      object_key = upload_data.original_filename

      aws_s3_service.upload(object_key, upload_data.tempfile)
      uploaded_url = ENV['AWS_FILE_URL'] + object_key

      # Upload to Uiza
      uiza_service = UizaService.new(ENV['UIZA_API_KEY'])
      entity = uiza_service.create(object_key, '', uploaded_url)
      puts entity

      # Publish to CDN
      uiza_service.publish(entity.id)

      # Create upload document
      upload = Upload.create(name: name, status: 2, uiza_id: entity.id)

      [true, upload, 200]
    rescue Exception => e
      [false, e.errors, 422]
    end
  end
end