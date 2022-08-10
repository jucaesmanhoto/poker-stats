class AddPrizeToTournamentPlayer < ActiveRecord::Migration[7.0]
  def change
    add_reference :tournament_players, :prize, foreign_key: true
  end
end
