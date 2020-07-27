class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:destroy]

  def create
    @cart_item = CartItem.new
    @cart_item.cart_id = current_user.carts.first.id
    @cart_item.package_id = (params[:package_id])
    # raise
    if @cart_item.save
      redirect_to cart_path(current_user.carts.first.id), notice: "Ajouté au panier !"
    else
      @cart_item.errors.full_messages
        render :new
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_path(current_user.carts.first.id), notice: "Supprimé !"
  end
  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:package_id, :cart_id)
  end


end
