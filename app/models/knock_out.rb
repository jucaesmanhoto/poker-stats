class KnockOut < ApplicationRecord
  belongs_to :ko_winner, class_name: TournamentPlayer
  belongs_to :ko_looser, class_name: TournamentPlayer
  has_many :tournament_knock_outs
  has_many :tournaments, through: :tournament_knock_outs
end
