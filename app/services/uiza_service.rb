require "uiza"

class UizaService
  def initialize(authorization_key)
    Uiza.authorization = authorization_key
  end

  def entity(uiza_id)
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

  def create(name, thumbnail, url)
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

  def update(uiza_id, name)
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

  def publish(uiza_id)
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

  def publish_status(uiza_id)
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

  def delete(uiza_id)
  end
end