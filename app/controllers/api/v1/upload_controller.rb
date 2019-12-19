class Api::V1::UploadController < BaseApiController
  def create
    upload_create_form = Upload::CreateForm.new(params)
    result = upload_create_form.create()
    if result[0]
      render json: {
        success: true, data: {upload: result[1]},
        message: 'Create upload object successful.'
      }
    else
      render json: {
        success: false, errors: result[1],
        message: 'Create upload object failed.'
      }, status: result[2]
    end
  end

  # def progress
  #   upload_progress_form = Upload::ProgressForm.new(params)
  #   result = upload_progress_form.progress()
  #   if result[0]
  #     render json: {
  #       success: true, data: {upload: result[1]},
  #       message: 'Upload successful.'
  #     }
  #   else
  #     render json: {
  #       success: false, errrors: result[1],
  #       message: 'Upload failed.'
  #     }, status: result[2]
  #   end
  # end
end