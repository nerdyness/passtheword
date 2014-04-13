require 'sinatra'
require './lib/hashme.rb'

class Server
  extend Hashme
end

get '/' do
  haml :index, :locals => {:timeout => Server.timeout}
end

post '/' do
  Server.hash2clipboard(params[:string])
  haml :index, :locals => {:timeout => Server.timeout}
end
