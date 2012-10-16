require 'sinatra'
require 'public_suffix'


get '/' do
  erb :index
end

get '/about' do
  erb :about
end

