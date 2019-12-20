require "uiza"

class UizaService
  def initialize(authorization_key)
    Uiza.authorization = authorization_key
  end

  def object(uiza_id)
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
      url: 'https://hoptq.s3-ap-southeast-1.amazonaws.com/Serija+%E2%80%9EPet%E2%80%9C%2C+06.+epizoda-JwGS3w5nKsg.mp4',
      inputType: "http"
    }

    begin
      entity = Uiza::Entity.create params
      puts entity.id
      puts entity.name
    rescue Uiza::Error::UizaError => e
      puts "description_link: #{e.description_link}"
      puts "code: #{e.code}"
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
      puts entity.id
      puts entity.name
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
      puts response.message
      puts response.entityId
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