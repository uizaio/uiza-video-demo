require 'aws-sdk-s3'
require 'aws-sdk-core'

class AwsS3Service
  attr_accessor :client, :bucket

  def initialize(region, bucket, access_key, secret_key, session_token = '')
    # Aws.config = {
    #   :access_key_id => access_key,
    #   :secret_access_key => secret_key,
    #   :session_token => session_token,
    #   :region => region
    # }

    # @client = Aws::S3::Client.new()

    #####
    # @client = Aws::S3::Client.new(
    #   region: region, access_key_id: access_key,
    #   secret_access_key: secret_key, session_token: session_token
    # )

    @client = Aws::S3::Resource.new(
      :access_key_id => access_key,
      :secret_access_key => secret_key,
      :region => region,
      :session_token => session_token
    )

    @bucket = bucket
  end

  def upload(bucket_name, file, video_name, s3_fix_file_name)
    # bucket_name = bucket_name

    path = bucket_name
    paths = path.split("/")
    obj = client.bucket(paths[0]).object(paths[1] + "/" + paths[2] + "/" + s3_fix_file_name )
    obj.upload_file(file)

    # Put an object in the public bucket
    # client.put_object({bucket: bucket, key: 'test', body: file})
  end
end