class Tournament < ApplicationRecord
    has_many :tournament_knock_outs
    has_many :knock_outs, through: :tournament_knock_outs

    has_many :tournament_players
    has_many :users, through: :tournament_players
    # has_many :players, through: :tournament_players

    has_many :tournament_tables
    has_many :tables, through: :tournament_tables

    has_many :prizes

    # validates :number, uniqueness: true
    validates :number, :buy_in_cents, :tax_cents, :started_at, presence: true
    validates :buy_in_cents, :tax_cents,
        numericality: { onli_integer: true }

end
