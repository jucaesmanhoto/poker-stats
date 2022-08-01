class CreateTournamentTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tournament_tables do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :table, null: false, foreign_key: true

      t.timestamps
    end
  end
end
