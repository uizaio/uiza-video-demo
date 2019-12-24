class VideosController < ApplicationController
  layout "show_player", only: [:show]
  def index
  end
  def show
    @video = Video.find_by_code(params[:code]).first
  end
end
