class CreateTournamentPlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :tournament_players do |t|
      t.integer :finished_at
      t.references :user, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
