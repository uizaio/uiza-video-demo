class LivesService
  def create(name, des)
    begin
      # Create uiza entity
      uiza_service = UizaService.new(ENV['UIZA_API_KEY'])
      res = uiza_service.live_create(name, des, ENV['UIZA_LIVE_REGION'])

      # Create upload document
      live = Live.create(name: name, des: des, uiza_id: res['id'])
      [true, live, 200]
    rescue Exception => e
      [false, e.errors, 422]
    end
  end
end