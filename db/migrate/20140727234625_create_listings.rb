class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.string :race
      t.date :raceday
      t.string :cause

      t.timestamps
    end
  end
end
