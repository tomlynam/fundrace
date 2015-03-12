class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :bets

	validates :name, :race, :cause, presence: true
	validate :raceday_cannot_be_in_the_past

	def raceday_cannot_be_in_the_past
    if raceday.present? && raceday < Date.today
      errors.add(:raceday, "can't be in the past")
    end
	end

	def complete
		bets.each do |bet|
		  donator = User.find_by_email(bet.email)
		  Stripe::Charge.create(
		    customer: donator.stripe_customer_id,
		    amount: (bet.calculated_amount * 100).to_i,
		    description: "Fundrace: #{raceday} for #{cause}",
		    currency: 'usd'
		  )
		end
	end
end
