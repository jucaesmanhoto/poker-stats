class CreateKnockOuts < ActiveRecord::Migration[7.0]
  def change
    create_table :knock_outs do |t|
      t.references :winner, null: false
      t.references :looser, null: false
      t.integer :looser_chips_amount

      t.timestamps
    end
    add_foreign_key :knock_outs, :tournament_players, column: :winner_id, primary_key: :id
    add_foreign_key :knock_outs, :tournament_players, column: :looser_id, primary_key: :id
  end
end
