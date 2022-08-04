class CreateHands < ActiveRecord::Migration[7.0]
  def change
    create_table :hands do |t|
      t.string :flop_first_card
      t.string :flop_second_card
      t.string :flop_third_card
      t.string :turn
      t.string :river
      t.string :number
      t.integer :dealer_seat_number

      t.timestamps
    end
  end
end
