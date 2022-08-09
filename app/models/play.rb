class Play < ApplicationRecord
  belongs_to :user
  belongs_to :hand

  validates :action, :chips_before_action, numericality: { only_integer: true }
  validates :action, :chips_before_action, presence: true
end
