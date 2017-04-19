class ChargesController < ApplicationController

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken],
      plan: "premium"
    )
    current_user.update_attributes(stripe_id: customer.id, role: "premium")
    flash[:notice] = "Thank you for going premium, #{current_user.username}!"
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @amount = 500
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Travelog Premium - #{current_user.email}",
      amount: @amount
    }
  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    current_user.update_attributes(role: "standard")
    current_user.downgrade
    flash[:notice] = "You have cancelled your premium account."
    redirect_to root_path
  end
end
