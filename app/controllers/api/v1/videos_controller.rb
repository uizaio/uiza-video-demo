class Api::V1::VideosController < BaseApiController
  def create
    upload_create_form = Videos::CreateForm.new(params)
    result = upload_create_form.create()
    if result[0]
      render json: {
        success: true, data: {upload: result[1]},
        message: 'Create video object successful.'
      }
    else
      render json: {
        success: false, errors: result[1],
        message: 'Create video object failed.'
      }, status: result[2]
    end
  end
end