class VideosController < ApplicationController
  layout "show_player", only: [:show]
  def index
  end
  def show
    @video = Video.find_by_code(params[:code]).first
    uiza_service = UizaService.new(ENV['UIZA_API_KEY'])
    result = uiza_service.video_play_url(@video.uiza_id)
  end
end
