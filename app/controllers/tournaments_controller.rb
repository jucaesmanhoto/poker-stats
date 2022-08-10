require 'date'

class TournamentsController < ApplicationController
  
  REGEX_TOURNAMENT_SUMMARY = {
    tournament: /Tournament.*#(?<number>\d*),/i,
    buy_in: /Buy-In:*.\$(?<buy_in>\d*\.\d{2})\/\$(?<tax>\d*\.\d{2})/i,
    number_of_seats: /(?<number_of_seats>\d*)\s{1}players/i,
    total_prize: /Total Prize Pool:\s*\$(?<total_prize>\d*\.\d{2})/i, 
    started_at: /Tournament started (?<y>\d{4})\/(?<M>\d{2})\/(?<d>\d{2}) (?<h>\d{2}):(?<m>\d{2}):(?<s>\d{2})/i,
    player: /\s*(?<position>\d*):\s(?<player_username>.*)\s\((?<country>.*)\),\s(?<still_playing>.*)?/i,
    player_prize: /\$(?<prize>\d*\.\d{2})\s*\((?<percentage_of_total_price>\d*\.\d*)\%\)/i,
    finished: /You finished in (?<finished_at>\d*).*#(?<hand_number>\d*)\)/i,
    rebuy: /\s\[(?<rebuy>\d*)\]/i,
  } 

  def new
    @tournament = Tournament.new
  end

  def create
    path = "/Users/jucaesmanhoto/Library/Application Support/PokerStars/TournSummary/JSE78/*"
    Dir[path].each do |file_path|
      # Garantees that will not load the file twice
      next unless new_tournament_file?(file_path)

      tournament = Tournament.new
      zero_prize = Prize.new
      File.open(file_path).each do |line|
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
            tournament.save!
            zero_prize.tournament = tournament
            zero_prize.prize_cents = 0
            zero_prize.place = 0
            zero_prize.save!
          end

          if match && key == :player
            player = helpers.get_or_create_player(match[:player_username])
            finished_at = match[:position].to_i
            # If the player is still playing, will get the position = 0
            if match[:still_playing].strip == "still playing" 
              finished_at = 0
            else
              match_prize_regex = line.match(REGEX_TOURNAMENT_SUMMARY[:player_prize])
              if match_prize_regex
                prize = Prize.create!(
                  place: match[:position].to_i,
                  prize_cents: (match_prize_regex[:prize].to_f * 100).to_i,
                  tournament: tournament
                )
              end
            end
            tournament_player = TournamentPlayer.new(
              user: player,
              tournament: tournament,
              finished_at: finished_at,
              prize: prize || zero_prize
            )
            tournament_player.save!
            prize = zero_prize
          end
        end
      end
    end
  end


  private

  def new_tournament_file?(file_path)
    tournament_numbers = current_user.tournaments.map(&:number)
    tournament_numbers.each do |number|
      return true if Tournament.find_by(number: number).num_of_seats.nil?
      return false if file_path.include?(number) 
    end
    return true
  end
end
