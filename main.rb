require 'rubygems'
require 'sinatra'
require "pry"

set :sessions, true

helpers do
  def calculate_total(cards) # cards is nested array
    arr = cards.map{|element| element[1]}

    total = 0
    arr.each do |a|
      if a == "A"
        total += 11
      else
        total += a.to_i == 0 ? 10 : a.to_i
      end
    end

  arr.select{|element| element == "A"}.count.times do
    break if total <=21
    total -= 10
    end

  total
  end
end

get '/' do
  if session[:username]
    redirect '/game'
  else 
    redirect '/new_player'
  end
end

get '/new_player' do
  erb :new_player
end

post '/new_player' do
  session[:player_name] = params[:player_name]
  redirect '/game'

end

get '/game' do
  # set up initial game values
  suits = %w[H D C S]
  values = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  session[:deck] = suits.product(values).shuffle!
  # deal cards
  session[:dealer_cards] = []
  session[:player_cards] = []
  session[:dealer_cards] << session[:deck].pop
  session[:player_cards] << session[:deck].pop
  session[:dealer_cards] << session[:deck].pop
  session[:player_cards] << session[:deck].pop

   # dealer cards
   # player cards
  erb :game
end