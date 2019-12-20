if Rails.env == 'production'
  Raven.configure do |config|
    config.dsn = ENV['RAVEN_DNS']
    config.environments = %w[ production ]
  end
end