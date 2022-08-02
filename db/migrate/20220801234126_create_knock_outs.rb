class CreateKnockOuts < ActiveRecord::Migration[7.0]
  def change
    create_table :knock_outs do |t|
      t.references :ko_winner, null: false, foreign_key: true
      t.references :ko_looser, null: false, foreign_key: true
      t.integer :looser_chips_amount

      t.timestamps
    end
  end
end
