#$redis = Redis.new(:host => '127.0.0.1', :port => 6379)
# Location: config/initializers/redis.rb
conf_file = File.join('config','redis.yml')

Redis.current = if File.exists?(conf_file)
  conf = YAML.load(File.read(conf_file))
  conf[Rails.env.to_s].blank? ? Redis.new : Redis.new(conf[Rails.env.to_s])
else
  Redis.new
end