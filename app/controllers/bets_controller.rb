class BetsController < ApplicationController
  def create
    bet = Bet.create(bet_params)
    bet.listing_id = params[:listing_id]
    if bet.save
      redirect_to listing_url(params[:listing_id]), flash: {
        notice: 'Your bet has been placed. Wish your runner good luck!'
      }
    else
      redirect_to listing_url(params[:listing_id]), flash: {
        error: 'Something went wrong. Please make sure you filled out all fields.'
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
