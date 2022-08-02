class TournamentKnockOut < ApplicationRecord
  belongs_to :tournament
  belongs_to :knock_out
end
