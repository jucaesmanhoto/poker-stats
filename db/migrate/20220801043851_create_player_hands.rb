class CreatePlayerHands < ActiveRecord::Migration[7.0]
  def change
    create_table :player_hands do |t|
      t.string :first_pocket_card
      t.string :second_pocket_card
      t.integer :seat_number
      t.references :hand, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
