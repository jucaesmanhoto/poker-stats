class InitialBetStructure < ApplicationRecord
    has_many :table_hands
    has_many :hands, through: :table_hands

    before_validation :fill_ante
    validates :big_blind, :small_blind, :ante, :level, presence: true
    validates :big_blind, :small_blind, :ante, :level, numericality: { only_integer: true }

    def fill_ante
        self.ante = 0 if self.ante.nil?   
    end
end
