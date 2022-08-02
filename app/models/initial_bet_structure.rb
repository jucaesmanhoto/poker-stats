class InitialBetStructure < ApplicationRecord
    has_many :table_rounds
    has_many :hands, through: :table_rounds
end
