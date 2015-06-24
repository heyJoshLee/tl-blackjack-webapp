require 'rubygems'
require 'sinatra'
require "pry"

set :sessions, true



get '/' do
  "Hello World"
end

get '/form' do
  erb :form
end

post '/login' do
  session[:username] = params[:username]
  puts session[:username]
  puts "I guess you can put middleware here"
  redirect '/login'
end

get '/users' do
  erb :"/users/profile"
end

get '/login' do
  erb :login
end

get "/profile" do
  erb :"/users/profile", layout: :"/users/user_layout"
end

get '/about_us' do
  redirect '/about'
end

get '/about' do
  erb :about
end


get '/test' do
  erb :test
end