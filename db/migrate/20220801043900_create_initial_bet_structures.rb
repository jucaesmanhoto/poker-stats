class CreateInitialBetStructures < ActiveRecord::Migration[7.0]
  def change
    create_table :initial_bet_structures do |t|
      t.integer :duration_in_seconds
      t.integer :big_blind
      t.integer :small_blind
      t.integer :ante
      t.integer :level

      t.timestamps
    end
  end
end
