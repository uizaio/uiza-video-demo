class Upload::CreateForm
  include ActiveModel::Model
  attr_accessor :file_local_path

  validates :file_local_path, presence: true

  def initialize(params)
    @file_local_path = params[:file_local_path]
  end

  def create
    if valid?
      upload_service = UploadService.new()
      upload_service.create(file_local_path)
    else
      [false, errors.messages, 400]
    end
  end
end