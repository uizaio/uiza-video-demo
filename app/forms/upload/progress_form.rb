class Upload::CreateForm
  include ActiveModel::Model
  attr_accessor :upload_data

  validates :upload_data, presence: true

  def initialize(params)
    @upload_data = params[:data]
  end

  def progress
    if valid?
      upload_service = UploadService.new()
      upload_service.progress(upload_data)
    else
      [false, errors.messages]
    end
  end
end