class Prize < ApplicationRecord
  belongs_to :tournament

  validates :place, :prize_cents, presence: true
end
