require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.set :sessions, false

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["admin", "admin@123456"]
end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379' }
  config.average_scheduled_poll_interval = 15
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379' }
end
