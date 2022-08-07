class CreateTableHands < ActiveRecord::Migration[7.0]
  def change
    create_table :table_hands do |t|
      t.references :table, null: false, foreign_key: true
      t.references :hand, null: false, foreign_key: true
      t.references :initial_bet_structure, null: false, foreign_key: true

      t.timestamps
    end
  end
end
