class UploadController < ApplicationController
  def index
  end

  def show
    @upload = Upload.find_by_code(params[:code]).first
  end
end
