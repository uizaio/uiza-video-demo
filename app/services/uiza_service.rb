class UizaService
  attr_accessor :authorization_key, :uiza_base_api_url

  def initialize(authorization_key)
    @authorization_key = authorization_key
    # Uiza.authorization = authorization_key

    @uiza_base_api_url = ENV['UIZA_BASE_API_URL']
  end

  def get_aws_key()
    begin
      res = Faraday.get do |req|
        req.url "#{uiza_base_api_url}/api/public/v4/admin/app/config/aws"
        req.headers['Authorization'] = authorization_key
        req.headers['Content-Type'] = 'application/json'
      end
      if res.status == 200
        return JSON.parse res.body
      else
        puts "Request fail. Status: #{res.status}. Message: #{res.body}"
        return nil
      end
    rescue Exception => e
      puts "ERROR: Request error. Message: #{e.message}"
      return nil
    end
  end

  # def video_entity(uiza_id)
  #   begin
  #     entity = Uiza::Entity.retrieve uiza_id
  #   rescue Uiza::Error::UizaError => e
  #     puts "description_link: #{e.description_link}"
  #     puts "code: #{e.code}"
  #     puts "message: #{e.message}"
  #   rescue StandardError => e
  #     puts "message: #{e.message}"
  #   end
  # end

  def video_entity(uiza_id)
    begin
      res = Faraday.get do |req|
        req.url "#{uiza_base_api_url}/v1/video_entities/#{uiza_id}"
        req.headers['Authorization'] = authorization_key
        req.headers['Content-Type'] = 'application/json'
      end
      if res.status == 200
        return JSON.parse res.body
      else
        puts "Request fail. Status: #{res.status}. Message: #{res.body}"
        return nil
      end
    rescue Exception => e
      puts "ERROR: Request error. Message: #{e.message}"
      return nil
    end
  end

  def video_play_url(uiza_id)
    # Get token
    token_res = Faraday.post do |req|
      req.url ENV['UIZA_GET_TOKEN_URL']
      req.headers['Content-Type'] = 'application/json'
      req.body = {entity_id: uiza_id, appId: ENV['UIZA_APP_ID'], content_type: 'stream'}.to_json
    end

    token = (JSON.parse token_res.body)['data']['token']
    begin
      res = Faraday.get do |req|
        req.url "#{ENV['UIZA_GET_PLAY_URL']}?entity_id=#{uiza_id}&app_id=#{ENV['UIZA_APP_ID']}&type_content=stream"
        req.headers['Authorization'] = token
        req.headers['Content-Type'] = 'application/json'
      end

      if res.status == 200
        return JSON.parse res.body
      else
        puts "Request fail. Status: #{res.status}. Message: #{res.body}"
        return nil
      end
    rescue Exception => e
      puts "ERROR: Request error. Message: #{e.message}"
      return nil
    end
  end

  # def video_create(name, thumbnail, url)
  #   params = {
  #     name: name,
  #     url: url,
  #     inputType: "http"
  #   }

  #   begin
  #     entity = Uiza::Entity.create params
  #   rescue Uiza::Error::UizaError => e
  #     puts "message: #{e.message}"
  #   rescue StandardError => e
  #     puts "message: #{e.message}"
  #   end
  # end

  def video_create(name)
    begin
      res = Faraday.post do |req|
        req.url "#{uiza_base_api_url}/v1/video_entities"
        req.headers['Authorization'] = authorization_key
        req.headers['Content-Type'] = 'application/json'
        req.body = { name: name, url: 's3+uiza+<entity_id>', inputType: 'S3_UIZA' }.to_json
      end
      if res.status == 200
        return JSON.parse res.body
      else
        puts "Request fail. Status: #{res.status}. Message: #{res.body}"
        return nil
      end
    rescue Exception => e
      puts "ERROR: Request error. Message: #{e.message}"
      return nil
    end
  end

  # def video_update(uiza_id, name)
  #   params = {
  #     id: uiza_id,
  #     name: name
  #   }

  #   begin
  #     entity = Uiza::Entity.update params
  #   rescue Uiza::Error::UizaError => e
  #     puts "description_link: #{e.description_link}"
  #     puts "code: #{e.code}"
  #     puts "message: #{e.message}"
  #   rescue StandardError => e
  #     puts "message: #{e.message}"
  #   end
  # end

  def video_publish(uiza_id)
    begin
      res = Faraday.post do |req|
        req.url "#{uiza_base_api_url}/v1/video_entities/#{uiza_id}/publish"
        req.headers['Authorization'] = authorization_key
        req.headers['Content-Type'] = 'application/json'
      end
      if res.status == 200
        return JSON.parse res.body
      else
        puts "Request fail. Status: #{res.status}. Message: #{res.body}"
        return nil
      end
    rescue Exception => e
      puts "ERROR: Request error. Message: #{e.message}"
      return nil
    end
  end

  # def video_publish(uiza_id)
  #   begin
  #     response = Uiza::Entity.publish uiza_id
  #   rescue Uiza::Error::UizaError => e
  #     puts "description_link: #{e.description_link}"
  #     puts "code: #{e.code}"
  #     puts "message: #{e.message}"
  #   rescue StandardError => e
  #     puts "message: #{e.message}"
  #   end
  # end

  def video_publish_status(uiza_id)
    begin
      res = Faraday.get do |req|
        req.url "#{uiza_base_api_url}/v1/video_entities/#{uiza_id}/publish/status"
        req.headers['Authorization'] = authorization_key
        req.headers['Content-Type'] = 'application/json'
      end
      if res.status == 200
        return JSON.parse res.body
      else
        puts "Request fail. Status: #{res.status}. Message: #{res.body}"
        return nil
      end
    rescue Exception => e
      puts "ERROR: Request error. Message: #{e.message}"
      return nil
    end
  end

  # def video_publish_status(uiza_id)
  #   begin
  #     response = Uiza::Entity.get_status_publish uiza_id
  #   rescue Uiza::Error::UizaError => e
  #     puts "description_link: #{e.description_link}"
  #     puts "code: #{e.code}"
  #     puts "message: #{e.message}"
  #   rescue StandardError => e
  #     puts "message: #{e.message}"
  #   end
  # end

  def live_create(name, des, region)
    res = Faraday.post do |req|
      req.url "#{uiza_base_api_url}/v1/live_entities"
      req.headers['Authorization'] = authorization_key
      req.headers['Content-Type'] = 'application/json'
      req.body = {name: name, description: des, region: region, dvr: true}.to_json
    end
    if res.status == 200
      return JSON.parse res.body
    else
      puts "ERROR: Response fail. Status: #{res.status}. Message: #{res.body}"
      return nil
    end
  end

  def live_entity(uiza_id)
    begin
      res = Faraday.get do |req|
        req.url "#{uiza_base_api_url}/v1/live_entities/#{uiza_id}"
        req.headers['Authorization'] = authorization_key
        req.headers['Content-Type'] = 'application/json'
      end
      if res.status == 200
        return JSON.parse res.body
      else
        puts "Request fail. Status: #{res.status}. Message: #{res.body}"
        return nil
      end
    rescue Exception => e
      puts "ERROR: Request error. Message: #{e.message}"
      return nil
    end
  end

  def live_update(uiza_id, name, des)
    begin
      res = Faraday.put do |req|
        req.url "#{uiza_base_api_url}/v1/live_entities/#{uiza_id}"
        req.headers['Authorization'] = authorization_key
        req.headers['Content-Type'] = 'application/json'
        req.body = {name: name, description: des}.to_json
      end

      if res.status == 200
        return JSON.parse res.body
      else
        puts "ERROR: Response fail. Status: #{res.status}. Message: #{res.body}"
        return nil
      end
    rescue Exception => e
      puts "ERROR: Request error. Message: #{e.message}"
      return nil
    end
  end

  def live_sessions()
    begin
      res = Faraday.put do |req|
        req.url "#{uiza_base_api_url}/v1/live_entities/#{uiza_id}"
        req.headers['Authorization'] = authorization_key
        req.headers['Content-Type'] = 'application/json'
        req.body = {name: name, description: des}.to_json
      end

      if res.status == 200
        return JSON.parse res.body
      else
        puts "ERROR: Response fail. Status: #{res.status}. Message: #{res.body}"
        return nil
      end
    rescue Exception => e
      puts "ERROR: Request error. Message: #{e.message}"
      return nil
    end
  end
end