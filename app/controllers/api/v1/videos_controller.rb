class Api::V1::VideosController < BaseApiController
  def create
    upload_create_form = Videos::CreateForm.new(params)
    result = upload_create_form.create()
    if result[0]
      render json: {
        success: true, data: {video: result[1]},
        message: 'Create video object successful.'
      }
    else
      render json: {
        success: false, errors: result[1],
        message: 'Create video object failed.'
      }, status: result[2]
    end
  end

  def publish_status
    uiza_id = params[:uiza_id]

    uiza_service = UizaService.new(ENV['UIZA_API_KEY'])
    publish_status = uiza_service.publish_status(uiza_id)
    publish_status_obj = Api::V1::Videos::PublishStatusViewObject.new(publish_status)
    render json: {
      success: true, data: {publish: publish_status_obj},
      message: 'Get publish status to CDN successful.'
    }
  end

  def entity
    uiza_id = params[:uiza_id]
    video = Video.where(uiza_id: uiza_id).first

    uiza_service = UizaService.new(ENV['UIZA_API_KEY'])
    entity = uiza_service.entity(uiza_id)
    entity_object = Api::V1::Videos::EntityViewObject.new(entity, video)
    render json: {
      success: true, data: {entity: entity_object.to_object},
      message: 'Get entity successful.'
    }
  end
end