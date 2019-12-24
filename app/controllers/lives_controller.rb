class LivesController < ApplicationController
  layout "show_player", only: [:show]
  def index
  end

  def detail
    @live = Live.find_by_code(params[:code]).first
  end

  def show
    @live = Live.find_by_code(params[:code]).first
  end
end
