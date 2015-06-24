require 'rubygems'
require 'sinatra'
require "pry"

set :sessions, true



post '/' do
  session[:username] = params[:username]
  if session[:username] != "" && session[:username]
    redirect '/home'
  else 
    redirect 'form'
  end
end

get '/' do
  session[:username] = params[:username]
  if !session[:username] || session[:username] != ""
    redirect '/form'
  else
    redirect '/home'
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