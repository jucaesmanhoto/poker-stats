class Table < ApplicationRecord
    has_many :table_rounds
    has_many :rounds, through: :table_rounds

    has_many :tournament_tables
    has_many :tournaments, through: :tournament_tables
end
