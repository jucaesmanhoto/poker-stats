class Hand < ApplicationRecord
    has_many :plays
    has_many :users, through: :plays

    has_many :player_hands
    has_many :users, through: :player_hands

    has_many :table_hands
    has_many :tables, through: :table_hands
end
