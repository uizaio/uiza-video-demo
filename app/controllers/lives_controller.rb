class LivesController < ApplicationController
  def index
  end

  def detail
    @live = Live.find_by_code(params[:code]).first
  end
end
