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

  def entity
    uiza_id = params[:uiza_id]
    live = Live.where(uiza_id: uiza_id).first

    uiza_service = UizaService.new(ENV['UIZA_LIVE_API_KEY'])
    live_entity = uiza_service.live_entity(uiza_id)
    live_entity_obj = Api::V1::Lives::EntityViewObject.new(live_entity, live).to_object
    render json: {
      success: true, data: {live: live_entity_obj},
      message: 'Get live entity successful.'
    }
  end
end