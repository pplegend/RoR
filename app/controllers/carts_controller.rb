class CartsController < ApplicationController
  before_filter :authenticate
  def add
    @product=Product.find(params[:id])
    @item=@cart.add(params[:id])
     respond_to do |format|
        format.html { redirect_to root_path }
        format.js 
     end
    
  end
 def cart_items_list
   
 end
end
