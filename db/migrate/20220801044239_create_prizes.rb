class CreatePrizes < ActiveRecord::Migration[7.0]
  def change
    create_table :prizes do |t|
      t.integer :place
      t.integer :prize_cents
      t.references :tournament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
