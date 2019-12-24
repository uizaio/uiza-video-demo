require "uiza"

class UizaService
  attr_accessor :authorization_key

  def initialize(authorization_key)
    @authorization_key = authorization_key
    Uiza.authorization = authorization_key
  end

  def video_entity(uiza_id)
    begin
      entity = Uiza::Entity.retrieve uiza_id
    rescue Uiza::Error::UizaError => e
      puts "description_link: #{e.description_link}"
      puts "code: #{e.code}"
      puts "message: #{e.message}"
    rescue StandardError => e
      puts "message: #{e.message}"
    end
  end

  def video_create(name, thumbnail, url)
    params = {
      name: name,
      url: url,
      inputType: "http"
    }

    begin
      entity = Uiza::Entity.create params
    rescue Uiza::Error::UizaError => e
      puts "message: #{e.message}"
    rescue StandardError => e
      puts "message: #{e.message}"
    end
  end

  def video_update(uiza_id, name)
    params = {
      id: uiza_id,
      name: name
    }

    begin
      entity = Uiza::Entity.update params
    rescue Uiza::Error::UizaError => e
      puts "description_link: #{e.description_link}"
      puts "code: #{e.code}"
      puts "message: #{e.message}"
    rescue StandardError => e
      puts "message: #{e.message}"
    end
  end

  def video_publish(uiza_id)
    begin
      response = Uiza::Entity.publish uiza_id
    rescue Uiza::Error::UizaError => e
      puts "description_link: #{e.description_link}"
      puts "code: #{e.code}"
      puts "message: #{e.message}"
    rescue StandardError => e
      puts "message: #{e.message}"
    end
  end

  def video_publish_status(uiza_id)
    begin
      response = Uiza::Entity.get_status_publish uiza_id
    rescue Uiza::Error::UizaError => e
      puts "description_link: #{e.description_link}"
      puts "code: #{e.code}"
      puts "message: #{e.message}"
    rescue StandardError => e
      puts "message: #{e.message}"
    end
  end

  def video_delete(uiza_id)
  end

  def live_create(name, des, region)
    res = Faraday.post do |req|
      req.url "#{ENV['UIZA_LIVE_BASE_API']}/v1/live_entities"
      req.headers['Authorization'] = authorization_key
      req.headers['Content-Type'] = 'application/json'
      req.body = {name: name, description: des, region: region}.to_json
    end

    if res.status == 200
      return JSON.parse res.body
    else
      return nil
    end
  end

  def live_object(uiza_id)
    res = Faraday.get do |req|
      req.url "#{ENV['UIZA_LIVE_BASE_API']}/v1/live_entities/#{uiza_id}"
      req.headers['Authorization'] = authorization_key
      req.headers['Content-Type'] = 'application/json'
    end

    if res.status == 200
      binding.pry
      return JSON.parse res.body
    else
      return nil
    end
  end

  def live_update(uiza_id, name, des)
    res = Faraday.put do |req|
      req.url "#{ENV['UIZA_LIVE_BASE_API']}/v1/live_entities/#{uiza_id}"
      req.headers['Authorization'] = authorization_key
      req.headers['Content-Type'] = 'application/json'
      req.body = {name: name, description: des}.to_json
    end

    if res.status == 200
      return JSON.parse res.body
    else
      return nil
    end
  end
end