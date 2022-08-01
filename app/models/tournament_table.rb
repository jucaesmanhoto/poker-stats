class TournamentTable < ApplicationRecord
  belongs_to :tournament
  belongs_to :table
end
