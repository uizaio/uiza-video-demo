class Api::V1::Videos::EntityViewObject
  attr_accessor :id, :name, :thumbnail, :duration, :publish_to_cdn, :view_url, :embbed

  def initialize(data, video)
    @id = data['id']
    @name = data['name']
    @thumbnail = data['thumbnail']
    @duration = data['duration']
    @publish_to_cdn = data['publishToCdn']
    @view_url = video.view_url
    @embbed = video.embbed
  end

  def to_object
    {
      id: id,
      name: name,
      thumbnail: thumbnail,
      duration: duration,
      publish_to_cdn: publish_to_cdn,
      view_url: view_url,
      embbed: embbed
    }
  end
end