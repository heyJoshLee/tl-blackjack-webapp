require 'rubygems'
require 'sinatra'

set :sessions, true



get '/' do
  "Hello World"
end

get '/about' do
  erb :about
end


get '/test' do
  erb :test
end