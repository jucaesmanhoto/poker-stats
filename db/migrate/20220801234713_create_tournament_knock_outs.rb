class CreateTournamentKnockOuts < ActiveRecord::Migration[7.0]
  def change
    create_table :tournament_knock_outs do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :knock_out, null: false, foreign_key: true

      t.timestamps
    end
  end
end
