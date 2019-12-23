module VideosHelper
  def is_videos_page?
    params[:controller] == 'videos'
  end
end
