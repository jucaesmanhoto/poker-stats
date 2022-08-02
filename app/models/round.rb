class Round < ApplicationRecord
    has_many :plays
    has_many :users, through: :plays

    has_many :player_hands
    has_many :users, through: :player_hands

    has_many :table_rounds
    has_many :tables, through: :table_rounds
end
