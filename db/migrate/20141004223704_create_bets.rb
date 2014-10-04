class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.references :listing, index: true
      t.string :name
      t.string :email
      t.float :starting_bet
      t.float :maximum_bet
      t.float :bonus_per_minute
      t.string :projected_finish_time

      t.timestamps
    end
  end
end
