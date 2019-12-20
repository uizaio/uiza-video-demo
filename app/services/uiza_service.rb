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
      name: "The Evolution of Dance",
      url: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4",
      inputType: "http",
      description: "Judson Laipply did a fantastic job in performing various dance moves",
      shortDescription: "How good a dancer can you be?"
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

  end

  def delete(uiza_id)
  end
end