PLATFORM = RUBY_PLATFORM

require 'bundler'
Bundler.require

require './remote_ip_app'

RemoteIpApp.set :run, false

run RemoteIpApp