require 'date'

class TournamentsController < ApplicationController
  
  REGEX_TOURNAMENT_SUMMARY = {
    tournament: /Tournament.*#(?<number>\d*),/i,
    buy_in: /Buy-In:*.\$(?<buy_in>\d*\.\d{2})\/\$(?<tax>\d*\.\d{2})/i,
    number_of_seats: /(?<number_of_seats>\d*)\s{1}players/i,
    total_prize: /Total Prize Pool:\s*\$(?<total_prize>\d*\.\d{2})/i, 
    started_at: /Tournament started (?<y>\d{4})\/(?<M>\d{2})\/(?<d>\d{2}) (?<h>\d{2}):(?<m>\d{2}):(?<s>\d{2})/i,
    player: /\s*(?<position>\d*):\s(?<player_name>.*)\s\((?<country>.*)\),\s(?<still_playing>.*)?/i,
    finished: /You finished in (?<finished_at>\d*).*#(?<hand_number>\d*)\)/i,
    rebuy: /\s\[(?<rebuy>\d*)\]/i
  } 

  def new
    @tournament = Tournament.new
  end

  def create
    path = "lib/assets/TS20220725.txt"
    tournament = Tournament.new
    File.open(path).each do |line|
       REGEX_TOURNAMENT_SUMMARY.each do |key, regexp|
            match = line.match(regexp)
            if match && key == :tournament
                tournament.number = match[:number]
            end
            if match && key == :buy_in
                tournament.buy_in_cents = (match[:buy_in].to_f * 100).to_i
                tournament.tax_cents = (match[:tax].to_f * 100).to_i
            end
            if match && key == :number_of_seats
                tournament.number_of_seats = match[:number_of_seats].to_i
            end
            if match && key == :total_prize
                tournament.total_prize_cents = (match[:total_prize].to_f * 100).to_i
            end
            if match && key == :started_at
                tournament.started_at = DateTime.new(
                    match[:y].to_i,
                    match[:M].to_i,
                    match[:d].to_i,
                    match[:h].to_i,
                    match[:m].to_i,
                    match[:s].to_i
                )
            end
            if match && key == :player
                create_player(match, tournament)
            end
            # TODO Save the finished place of the player
            # if match && key == :finished
            #     tournament_player = TournamentPlayer.where(tournament: tournament, user: current_user)
            #     tournament_player.finished_at = match[:finished_at].to_i
            #     raise
            #     tournament_player.save
            # end
       end
    end
    tournament.save
end


private

def create_player(match, tournament)
    name = match[:player_name]
    if name.include?("[")
        name_array = name.split
        rebuy = name_array.last.gsub("[", "").gsub("]", "").to_i
        name_array.pop        
        name = name_array.join
        p name
    end
    
    player =  Player.find_by(username: name)
    if player.nil?
        player = Player.create(username: name, email: "#{name.gsub(' ', '')}@email.com", password: '123456')
    end
    TournamentPlayer.create(tournament: tournament, user: player, finished_at: match[:position])
end

end