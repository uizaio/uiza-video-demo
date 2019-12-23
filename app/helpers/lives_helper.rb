module LivesHelper
  def is_lives_page?
    params[:controller] == 'lives'
  end
end
