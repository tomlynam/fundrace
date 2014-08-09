class Listing < ActiveRecord::Base

	validates :name, :race, :cause, presence: true

	validate :raceday_cannot_be_in_the_past
 
	def raceday_cannot_be_in_the_past
	    if raceday.present? && raceday < Date.today
	      errors.add(:raceday, "can't be in the past")
	    end
	end

	belongs_to :user

	##has_attached_file :avatar, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg"

end