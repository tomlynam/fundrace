class Bet < ActiveRecord::Base
  belongs_to :listing

  validates_presence_of :name, :email, :starting_bet,
                        :maximum_bet, :bonus_per_minute,
                        :projected_finish_time

  def calculated_amount
    starting_bet
  end
end
