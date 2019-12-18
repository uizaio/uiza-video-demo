if Rails.env == 'production'
  Raven.configure do |config|
    config.dsn = env['RAVEN_DNS']
    config.environments = %w[ production ]
  end
end