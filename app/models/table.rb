class Table < ApplicationRecord
    has_many :table_hands
    has_many :hands, through: :table_hands

    has_many :tournament_tables
    has_many :tournaments, through: :tournament_tables

    validates :number, :number_of_seats, presence: true
    validates :number_of_seats, numericality: { only_integer: true }
end
