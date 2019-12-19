class UploadController < ApplicationController
  def index
  end

  def edit
    @upload = Upload.find_by_code(params[:code])
  end
end
