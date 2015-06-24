require 'rubygems'
require 'sinatra'
require "pry"

set :sessions, true



post '/' do
  if !session[:username]
    session[:username] = params[:username]
  elsif session[:username] != "" && session[:username]
    redirect '/home'
  else 
    redirect 'form'
  end
end

get '/' do
  if !session[:username]
    session[:username] = params[:username]
  elsif session[:username] != "" && session[:username]
    redirect '/home'
  else 
    redirect 'form'
  end
end

get '/form' do
  erb :form
end



get '/home' do
  if !session[:username] || session[:username] == ""
    redirect '/form'
  end
  erb :home
end