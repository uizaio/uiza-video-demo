class Api::V1::Lives::EntityViewObject
  attr_accessor :uiza_id, :live_id, :name, :description, :stream_url, :stream_key, :region, :status

  def initialize(data, live)
    @uiza_id = data['id']
    @live_id = data['live_id']
    @name = data['name']
    @description = data['description']
    @stream_url = data['ingest'] ? data['ingest']['url'] : ''
    @stream_key = data['ingest'] ? data['ingest']['key'] : ''
    @region = data['region']
    @status = data['status']
  end

  def to_object
    {
      uiza_id: uiza_id,
      live_id: live_id,
      name: name,
      description: description,
      stream_url: stream_url,
      stream_key: stream_key,
      region: region,
      status: status
    }
  end
end