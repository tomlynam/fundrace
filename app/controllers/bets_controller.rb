class BetsController < ApplicationController
  def create
    bet = Bet.create(bet_params)
    bet.listing_id = params[:listing_id]
    bet.name = current_user.name
    bet.email = current_user.email

    unless current_user.stripe_customer_id.present?
      expiration_month, expiration_year = params[:payment][:cc_exp].split('/')
      stripe_customer = Stripe::Customer.create(
        description: params[:email],
        card: {
          number: params[:payment][:cc_number],
          exp_month: expiration_month,
          exp_year: expiration_year,
          name: current_user.name,
        }
      )

      current_user.update_attribute(:stripe_customer_id, stripe_customer.id)
    end

    binding.pry

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

  def payment_params
    params.require(:payment).permit(
      :cc_number,
      :cc_exp,
      :cc_ccv,
    )
  end
end
