class VideosService
  def create(name, upload_data)
    begin
      # Upload to S3 and get URL
      aws_s3_service = AwsS3Service.new(ENV['AWS_REGION'], ENV['AWS_BUCKET'])
      object_key = upload_data.original_filename

      aws_s3_service.upload(object_key, upload_data.tempfile)
      uploaded_url = ENV['AWS_FILE_URL'] + object_key

      # Upload to Uiza
      uiza_service = UizaService.new(ENV['UIZA_API_KEY'])
      entity = uiza_service.video_create(object_key, '', uploaded_url)

      # Publish to CDN
      uiza_service.video_publish(entity.id)

      # Create upload document
      video = Video.create(name: name, status: 2, uiza_id: entity.id)
      video.view_url = view_url(video)
      video.embbed = embbed_video(video)
      video.save

      [true, video, 200]
    rescue Exception => e
      [false, e.errors, 422]
    end
  end

  def view_url(video)
    "/videos/#{video.code}"
  end

  def embbed_video(video)
    embed_str = "<iframe id='iframe-#{video.uiza_id}' width='100%' height='100%' src='https://sdk.uiza.io/#/#{ENV['UIZA_APP_ID']}/publish/#{video.uiza_id}/embed?iframeId=iframe-#{video.uiza_id}&env=prod&version=4&api=YXAtc291dGhlYXN0LTEtYXBpLnVpemEuY28=&playerId=#{ENV['UIZA_PLAYER_ID']}' frameborder='0' allowfullscreen='allowfullscreen' webkitallowfullscreen='webkitallowfullscreen' mozallowfullscreen='mozallowfullscreen' allow='autoplay; fullscreen; encrypted-media'></iframe><script src='https://sdk.uiza.io/iframe_api.js'/></script>"
  end
end