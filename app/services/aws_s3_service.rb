require 'aws-sdk-s3'

class AwsS3Service
  attr_accessor :client, :bucket

  def initialize(region, bucket)
    # Create a S3 client
    @client = Aws::S3::Client.new(region: region)
    @bucket = bucket
  end

  def upload(object_key, file)
    object_key = object_key
    # Put an object in the public bucket
    client.put_object({
      acl: "public-read",
      bucket: bucket,
      key: object_key,
      body: file,
    })
  end
end