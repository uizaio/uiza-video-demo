class Videos::CreateForm
  include ActiveModel::Model
  attr_accessor :name, :data

  validates :name, :data, presence: true

  def initialize(params)
    @data = params[:data]
    @name = params[:name]
  end

  def create
    if valid?
      upload_service = VideosService.new()
      upload_service.create(name, data)
    else
      [false, errors.messages, 400]
    end
  end
end