# class Upload::ProgressForm
#   include ActiveModel::Model
#   attr_accessor :upload_data, :upload_code

#   validates :upload_data, presence: true

#   def initialize(params)
#     @upload_data = params[:data]
#     @upload_code = params[:code]
#   end

#   def progress
#     if valid?
#       upload_service = UploadService.new()
#       upload_service.progress(upload_code, upload_data)
#     else
#       [false, errors.messages, 400]
#     end
#   end
# end