class VideosController < ApplicationController
  def index
  end

  def show
    @video = Video.find_by_code(params[:code]).first
  end
end
