class BetsController < ApplicationController
  def create
    bet = Bet.create(bet_params)
    bet.listing_id = params[:listing_id]
    if bet.save!
      redirect_to listings_url(params[:listing_id]), flash: {
        success: 'Your bet has been placed. Wish your runner good luck!'
      }
    else
      redirect_to listings_url(params[:listing_id]), flash: {
        success: 'Uh oh, something broke. Please contact the dev team.'
      }
    end
  end

  private

  def bet_params
    params.require(:bet).permit(
      :name,
      :email,
      :starting_bet,
      :maximum_bet,
      :bonus_per_minute,
      :projected_finish_time
    )
  end
end
