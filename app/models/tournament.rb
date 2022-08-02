class Tournament < ApplicationRecord
    has_many :tournament_knock_outs
    has_many :knock_outs, through: :tournament_knock_outs

    has_many :tournament_players
    has_many :users, through: :tournament_players, as: 'players'

    has_many :tournament_tables
    has_many :tables, through: :tournament_tables

    has_many :prizes
end
