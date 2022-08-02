class InitialBetStructure < ApplicationRecord
    has_many :table_hands
    has_many :hands, through: :table_hands
end
