class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :initialize_cart
 
  private
  def initialize_cart
    
     @categories=Category.all
    if session[:cart_id]
       @cart=Cart.find(session[:cart_id])
    else
       @cart=Cart.create
       session[:cart_id]=@cart.id
    end
  end
end
