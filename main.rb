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

  def card_image(card) # ["H", "4"]
    suit = case card[0]
      when "H" then "hearts"
      when "D" then "diamonds"
      when "C" then "clubs"
      when "S" then "spades"
    end

    value = card[1]
    if ['J', "Q", "K", "A"].include?(value)
      value = case card[1]
        when "J" then "jack"
        when "Q" then "queen"
        when "K" then "king"
        when "A" then "ace"
      end
    end
    
    "<img src='/images/cards/#{suit}_#{value}.jpg' class='card_image'>"
  end


end




before do
  @show_hit_or_stay_buttons = true
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
  if params[:player_name].empty?
    @error = "Name is required"
    halt erb(:new_player)
  end

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

post '/game/player/hit' do
  session[:player_cards] << session[:deck].pop
  player_total = calculate_total(session[:player_cards])
  if player_total == 21
    @success = "Congrats! #{session[:player_name]} hit blackjack"
    @show_hit_or_stay_buttons = false
  elsif calculate_total(session[:player_cards]) > 21
    @error = "Sorry, #{session[:player_name]} busted."
    @show_hit_or_stay_buttons = false
  end

  erb :game
end


post '/game/player/stay' do
  @success = "#{session[:player_name]} has chosen to stay"
  @show_hit_or_stay_buttons = false
  erb :game
  end




