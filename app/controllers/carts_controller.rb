class CartsController < ApplicationController
  def add
    @product=Product.find(params[:id])
    @item=@cart.add(params[:id])
     respond_to do |format|
        format.html { redirect_to root_path }
        format.js 
     end
    
  end
end
