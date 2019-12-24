class LivesService
  def create(name, des)
    begin
      # Create upload document
      live = Live.create(name: name, des: des)
      [true, live, 200]
    rescue Exception => e
      [false, e.errors, 422]
    end
  end
end