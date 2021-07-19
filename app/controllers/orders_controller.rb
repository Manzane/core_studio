class OrdersController < ApplicationController
  before_action :set_order, only: [:show]
  def index
    @orders = current_user.orders.all
  end

  def show
  end

  def new
    # @order = Order.new
    # credits = current_user.credits.find_by(category_id: @lesson.category_id)
    # if credits
    #   @credits = credits.quantity
    # else
    #   redirect_to packages_path, notice: "Il vous faut des crédits pour réserver une séance"
    # end
  end

  def create
    cart = Cart.find(params[:cart_id])
    # raise
    @order = Order.create!(date: Time.now, amount: cart.amount, state: "en cours", user: current_user, cart: cart, status: 0)     
  #   session = Stripe::Checkout::Session.create(
  #     payment_method_types: ['card'],
  #     line_items: [{
  #       name: cart.packages,
  #       amount: cart.amount_cents,
  #       currency: 'eur',
  #       quantity: 1
  #     }],
  #     success_url: order_url(@order),
  #     cancel_url: order_url(@order)
  #   )
  #  @order.update(checkout_session_id: session.id)
  #   # redirect_to new_order_payment_path(order)


    if @order.save
      # credits_updater = CreditsUpdater.new(params, current_user)
      # credits_updater.order
      Cart.create(user: current_user)
      flash.now[:alert] = "Commande effectuée, dès réception du paiement votre compte sera crédité"
      redirect_to orders_path
      # redirect_to new_order_payment_path(@order)
    else
      flash.now[:alert] = "Commande non effectuée"
      redirect_to orders_path
    end 
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end
  # def order_params
  #   params.require(:order).permit(:quantity)
  # end
end
