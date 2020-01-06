class VideosService
  def create(name, upload_data)
    begin
      uiza_service = UizaService.new(ENV['UIZA_API_KEY'])
      video_name = upload_data.original_filename
      extension_video = File.extname(video_name)
      # Create uiza entity
      entity = uiza_service.video_create(video_name)
      uiza_id = entity['id']
      s3_fix_file_name = "s3+uiza+#{uiza_id}#{extension_video}"
      puts "uiza_id: #{uiza_id}"

      # Get S3 info
      s3_info = uiza_service.get_aws_key()
      region = s3_info['data']['region_name']
      access_key = s3_info['data']['temp_access_id']
      secret_key = s3_info['data']['temp_access_secret']
      session_token = s3_info['data']['temp_session_token']
      bucket_name = s3_info['data']['bucket_name']
      bucket = bucket_name.split('/')[0]

      # Upload to S3 and get URL
      aws_s3_service = AwsS3Service.new(region, bucket, access_key, secret_key, session_token)
      aws_s3_service.upload(bucket_name, upload_data.tempfile, video_name, s3_fix_file_name)

      # Publish to CDN
      uiza_service.video_publish(entity['id'])

      # Create upload document
      video = Video.create(name: name, status: 2, uiza_id: entity['id'])
      video.view_url = view_url(video)
      video.embbed = embbed_video(video)
      video.save

      [true, video, 200]
    rescue Exception => e
      puts "Video Service: #{e.message}"
      [false, e.message, 422]
    end
  end

  def view_url(video)
    "/videos/#{video.code}"
  end

  def embbed_video(video)
    embed_str = "<iframe id='iframe-#{video.uiza_id}' width='100%' height='100%' src='https://sdk.uiza.io/#/#{ENV['UIZA_APP_ID']}/publish/#{video.uiza_id}/embed?iframeId=iframe-#{video.uiza_id}&env=prod&version=4&api=YXAtc291dGhlYXN0LTEtYXBpLnVpemEuY28=&playerId=#{ENV['UIZA_PLAYER_ID']}' frameborder='0' allowfullscreen='allowfullscreen' webkitallowfullscreen='webkitallowfullscreen' mozallowfullscreen='mozallowfullscreen' allow='autoplay; fullscreen; encrypted-media'></iframe><script src='https://sdk.uiza.io/iframe_api.js'/></script>"
  end
end