class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.integer :number_of_seats

      t.timestamps
    end
  end
end
