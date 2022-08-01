class CreateTableRounds < ActiveRecord::Migration[7.0]
  def change
    create_table :table_rounds do |t|
      t.references :table, null: false, foreign_key: true
      t.references :round, null: false, foreign_key: true

      t.timestamps
    end
  end
end
