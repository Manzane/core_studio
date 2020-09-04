class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:destroy]
  before_action :set_cart

  def create
    @cart_item = CartItem.new
    @cart_item.cart_id = @cart.id
    package = Package.find(params[:package_id])
    @cart_item.package_id = package.id
    
    # raise
    if @cart_item.save
      new_amount = @cart.amount + package.price
      @cart.update!(amount: new_amount)
      # raise
      redirect_to cart_path(@cart), notice: "Ajouté au panier !"
    else
      @cart_item.errors.full_messages
        render :new
    end
  end

  def destroy
    price = @cart_item.package.price
    new_amount = @cart.amount - price
    # raise
    @cart.update!(amount: new_amount)
    # raise
    @cart_item.destroy
    redirect_to cart_path(@cart), notice: "Supprimé !"
  end
  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:package_id, :cart_id)
  end

  def set_cart
    # @cart = Cart.find(current_user.cart.id)
    @cart = Cart.find(params[:cart_id])
  end


end
