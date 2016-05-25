Encoding.default_external = 'utf-8'  if defined?(::Encoding)

class RemoteIpApp < Sinatra::Base
  configure do
    # set sinatra's variables
    set :app_file, __FILE__
    set :root, File.dirname(__FILE__)
    set :views, 'views'
    set :public_folder, 'public'
    set :json_encoder, :to_json

    enable :logging
  end

  redis = Redis.new(:db => 0)

  get '/update/:hostname' do
    ip_address = request.ip
    hostname = params[:hostname] || 'default'
    redis.set "remote_ip:hosts:#{hostname}", ip_address
    return ip_address
  end

  get '/:hostname' do
    hostname = params[:hostname]
    return redis.get "remote_ip:hosts:#{hostname}"
  end

  get '/' do
    'It Works!'
  end

end
