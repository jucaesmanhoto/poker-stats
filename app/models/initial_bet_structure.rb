class InitialBetStructure < ApplicationRecord
    has_many :table_rounds
    has_many :rounds, through: :table_rounds
end
