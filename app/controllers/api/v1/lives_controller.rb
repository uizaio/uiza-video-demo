class Api::V1::LivesController < BaseApiController
  def create
    live_create_form = Lives::CreateForm.new(params)
    result = live_create_form.create()
    if result[0]
      render json: {
        success: true, data: {live: result[1]},
        message: 'Create live object successful.'
      }
    else
      render json: {
        success: false, errors: result[1],
        message: 'Create live object failed.'
      }, status: result[2]
    end
  end
end