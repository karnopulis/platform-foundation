class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_cart

  def current_cart
    if !session[:cart_id].nil?
      begin
        Cart.find(session[:cart_id])
      # rescue Exception => exc
      #   cn= Cart.new(:total =>0, :total_price =>0)
      #   session[:cart_id]=cn.id
      #   cn.save
      #   return cn
      end
    else
      Cart.new(:total =>0, :total_price =>0)
    end
  end
end
