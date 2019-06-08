Sidekiq::Extensions.enable_delay!
if Rails.env.production? || Rails.env.staging?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDISTOGO_URL'], :size => 4 }
      # Set the db pool size for heroku
  	ENV['DATABASE_URL'] += "?pool=#{ENV['DB_POOL'] || Sidekiq.options[:concurrency]}" if ENV['DATABASE_URL']

	Rails.application.config.after_initialize do
		ActiveRecord::Base.connection_pool.disconnect!

		ActiveSupport.on_load(:active_record) do
		  config = ActiveRecord::Base.configurations[Rails.env] ||
                Rails.application.config.database_configuration[Rails.env]
		  config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
		  config['pool'] = ENV['DB_POOL'] || Sidekiq.options[:concurrency]
		  ActiveRecord::Base.establish_connection(config)

		  Rails.logger.info("Connection Pool size for Sidekiq Server is now: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
		end
	end
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDISTOGO_URL'], :size => 2 }
    Rails.application.config.after_initialize do
	    ActiveRecord::Base.connection_pool.disconnect!

	    ActiveSupport.on_load(:active_record) do
	      config = ActiveRecord::Base.configurations[Rails.env] ||
                Rails.application.config.database_configuration[Rails.env]
	      config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
	      config['pool'] = ENV['DB_POOL'] || 10
	      ActiveRecord::Base.establish_connection(config)

	      # DB connection not available during slug compliation on Heroku
	      Rails.logger.info("Connection Pool size for web server is now: #{config['pool']}")
	    end
  	end
  end
end