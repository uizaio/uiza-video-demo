class UploadController < ApplicationController
  def index
  end

  def edit
    @upload = Upload.find params[:id]
  end
end
