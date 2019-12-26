class LivesController < ApplicationController
  layout "show_player", only: [:show]
  def index
  end

  def detail
    @live = Live.find_by_code(params[:code]).first
    uiza_service = UizaService.new(ENV['UIZA_LIVE_BASE_API'])
    uiza_live_info = uiza_service.live_entity(@live.uiza_id)
    if uiza_live_info && uiza_live_info['ingest']
      @live.update(
        stream_url: uiza_live_info['ingest']['url'],
        stream_key: uiza_live_info['ingest']['key']
      )
    end
  end

  def show
    @live = Live.find_by_code(params[:code]).first
  end
end
