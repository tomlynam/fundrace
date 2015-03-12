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

end
