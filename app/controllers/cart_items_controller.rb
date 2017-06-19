class CartItemsController < ApplicationController
  def index
    @top_collection = Collection.find_by parent: nil
    @collection = Collection.find_by permalink: params[:id]||"parent"
    if @collection.nil? 
      raise ActionController::RoutingError.new('Not Found')
    end
    @cart = current_cart
    puts @collection.title
    puts @top_collection.subcollections.first.title
  end

  def create
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by variant_id: cart_item_params[:variant_id] 

    if @cart_item 
      
      @cart_item.quantity+= cart_item_params[:quantity].to_i if @cart_item.valid?
      @cart_item.save
    else
      @cart_item = @cart.cart_items.new(cart_item_params)
    end
    @cart.total_add(@cart_item.variant,cart_item_params[:quantity])
    session[:cart_id] = @cart.id

    @cart.save
  end
  
  def update
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by id: params[:id]
    if @cart_item.quantity > cart_item_params[:quantity].to_i
      @cart.total_substract(@cart_item.variant, @cart_item.quantity - cart_item_params[:quantity].to_i)
    else
            @cart.total_add(@cart_item.variant, cart_item_params[:quantity].to_i - @cart_item.quantity)
    end
    @cart_item.update_attributes(cart_item_params)
    @cart_items = @cart.cart_items
  end

  def destroy
    @cart = current_cart
    if params[:id]==nil
      @cart.cart_items.delete_all
      redirect_to "/cart_items"
      @cart.total = 0
      @cart.total_price = 0 
      @cart.save
      return
    end
      
    @cart_item = @cart.cart_items.find(params[:id])
    @cart.total_substract(@cart_item.variant,@cart_item.quantity)
    @cart_item.destroy

  end
  
  def cart_item_params
    params.require(:cart_item).permit(:quantity, :variant_id,:ku)
  end
end
