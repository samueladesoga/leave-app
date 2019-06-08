workers Integer(ENV['WEB_CONCURRENCY'] || 2)  
threads_count = Integer(ENV['MAX_THREADS'] || 1)  
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup  
port        ENV.fetch('PORT') { 5000 }  
environment ENV.fetch("RAILS_ENV") { "development" }

# Because we are using preload_app, an instance of our app is created by master process (calling our initializers) and then memory space
# is forked. So we should close DB connection in the master process to avoid connection leaks.
# https://github.com/puma/puma/issues/303
# http://stackoverflow.com/questions/17903689/puma-cluster-configuration-on-heroku
# http://www.rubydoc.info/gems/puma/2.14.0/Puma%2FDSL%3Abefore_fork
# Dont have to worry about Sidekiq's connection to Redis because connections are only created when needed. As long as we are not
# queuing workers when rails is booting, there will be no redis connections to disconnect, so it should be fine.
before_fork do  
  require 'puma_worker_killer'
  PumaWorkerKiller.config do |config|
      config.ram           = 1024 # mb
      config.frequency     = 60    # seconds
      config.percent_usage = 0.98
      config.rolling_restart_frequency = 12 * 3600 # 12 hours in seconds
    end
  PumaWorkerKiller.start
  puts "Puma master process about to fork. Closing existing Active record connections."
  ActiveRecord::Base.connection.disconnect!
end

on_worker_boot do  
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  @sidekiq_pid ||= spawn('bundle exec sidekiq -C config/sidekiq.yml')
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] ||
                Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['MAX_THREADS'] || 10
    ActiveRecord::Base.establish_connection(config)
  end
end

plugin :tmp_restart
