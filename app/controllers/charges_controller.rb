class ChargesController < ApplicationController
  
  def new
  end

  def create
    @amount = params[:amount]
    @token = params[:stripeToken]

    @amount = @amount.gsub('$', '').gsub(',', '')

    

    begin
      @amount = Float(@amount).round(2)
    rescue
      flash[:error] = 'Charge not completed. Please enter a valid amount in USD ($).'
      redirect_to new_charge_path
      return
    end

  @amount = (@amount * 100).to_i # Must be an integer!

  if @amount < 100
    flash[:error] = 'Charge not completed. Donation amount must be at least $1.'
    redirect_to new_charge_path
    return
  end

  Stripe::Charge.create(
    :amount => @amount,
    :currency => 'usd',
    :source => @token,
    :description => 'Custom donation'
    )



rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
end
end

