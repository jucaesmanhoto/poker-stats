class TournamentPlayer < ApplicationRecord
  belongs_to :user
  belongs_to :tournament
  has_many :knock_outs
end
