class ProductController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @cart_item = current_cart.cart_items.new

  end
end
