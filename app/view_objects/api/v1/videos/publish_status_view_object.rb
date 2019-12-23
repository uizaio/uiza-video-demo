class Api::V1::Videos::PublishStatusViewObject
  attr_accessor :progress, :status

  def initialize(data)
    @progress = data[:progress]
    @status = data[:status]
  end

  def to_object
    {
      progress: progress,
      status: status
    }
  end
end