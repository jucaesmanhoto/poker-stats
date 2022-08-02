class CreateHands < ActiveRecord::Migration[7.0]
  def change
    create_table :hands do |t|
      t.string :flop
      t.string :turn
      t.string :river

      t.timestamps
    end
  end
end
