class Table < ApplicationRecord
    has_many :table_hands
    has_many :hands, through: :table_hands

    has_many :tournament_tables
    has_many :tournaments, through: :tournament_tables
end
