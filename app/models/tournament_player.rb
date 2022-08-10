class TournamentPlayer < ApplicationRecord
  belongs_to :user
  belongs_to :tournament
  belongs_to :prize

  has_many :knock_outs
end
