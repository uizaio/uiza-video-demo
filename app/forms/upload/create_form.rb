class Upload::CreateForm
  include ActiveModel::Model
  attr_accessor :file_local_path, :name

  validates :file_local_path, :name, presence: true

  def initialize(params)
    @file_local_path = params[:file_local_path]
    @name = params[:name]
  end

  def create
    if valid?
      upload_service = UploadService.new()
      upload_service.create(name, file_local_path)
    else
      [false, errors.messages, 400]
    end
  end
end