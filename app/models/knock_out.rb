class KnockOut < ApplicationRecord
  belongs_to :winner, class_name: 'TournamentPlayer'
  belongs_to :looser, class_name: 'TournamentPlayer'
  has_many :tournament_players
  has_many :users, through: :tournament_players
  has_many :tournament_knock_outs
  has_many :tournaments, through: :tournament_knock_outs
end
