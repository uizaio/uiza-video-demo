class Api::V1::Videos::PublishStatusViewObject
  attr_accessor :process, :status

  def initialize(data)
    @process = data['process']
    @status = data['status']
  end

  def to_object
    {
      process: process,
      status: status
    }
  end
end