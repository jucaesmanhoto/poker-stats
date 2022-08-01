class CreatePlays < ActiveRecord::Migration[7.0]
  def change
    create_table :plays do |t|
      t.string :action
      t.integer :chips
      t.references :user, null: false, foreign_key: true
      t.references :round, null: false, foreign_key: true

      t.timestamps
    end
  end
end
