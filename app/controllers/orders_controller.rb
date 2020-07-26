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
    cart = Cart.first
    user = current_user
    @order = Order.create!(date: Time.now, amount: 1500, state: "en cours", user: user, cart: cart)
    
    # // params -> cart -> cart.packages - package.category_id, cart.packages - package.quantity
    
    if @order.save
      credits_updater = CreditsUpdater.new(params, current_user)
      # // category, et la quantité + user//
      credits_updater.order
      redirect_to orders_path, notice: "Commande effectuée et compte crédité"
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
