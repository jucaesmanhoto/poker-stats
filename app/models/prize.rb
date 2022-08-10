class Prize < ApplicationRecord
  belongs_to :tournament

  has_one :tournament_player
  
  validates :place, :prize_cents, presence: true
end
