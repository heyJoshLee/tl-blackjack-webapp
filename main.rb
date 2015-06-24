require 'rubygems'
require 'sinatra'
require "pry"

set :sessions, true

post '/' do
  if !session[:username]
    session[:username] = params[:username]
  elsif session[:username] != params[:username] && (session[:username] != "" && session[:username])
    session[:username] = params[:username]
    redirect '/game'
  elsif session[:username] != "" && session[:username]
    redirect '/game'
  else 
    redirect '/login'
  end
end

get '/' do
  if !session[:username]
    session[:username] = params[:username]
  elsif session[:username] != "" && session[:username]
    redirect '/game'
  else 
    redirect 'login'
  end
end

get '/login' do
  erb :login
end



get '/game' do
  if !session[:username] || session[:username] == ""
    redirect '/login'
  end
  erb :game
end