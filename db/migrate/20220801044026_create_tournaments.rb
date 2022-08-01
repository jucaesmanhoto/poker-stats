class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.string :number
      t.integer :buy_in_cents
      t.integer :number_of_seats
      t.integer :tax_cents
      t.datetime :started_at
      t.integer :initial_chips
      t.integer :total_prize_cents

      t.timestamps
    end
  end
end
