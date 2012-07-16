class CheckoutsController < ApplicationController

  def index
   @order=Order.new()
   @title="Checkout"
   if @cart.products.empty?
    flash[:notice]="Your shopping cart is empty!"
    redirect_to :controller=>'products'
   end
  end


  def place_order
   @title="Checkout"
   @order=Order.new(params[:order])
   @order.customer_ip=request.remote_ip
 
   populate_order
   if @order.save!
     if @order.process
       flash[:notice]="Your order has been submitted and will be processed immediately"
       session[:order_id]=@order.id
       #empty cart
       @cart.cart_items.destroy_all
       redirect_to :action=>'thank_you'
      else
       flash[:notice]="Error while placing order #{@order.error_message}"
       render :action=>'index'
     end
    else
     flash[:notice]="Your has been submitted and will be processed immediately"
     render :action=>'index'
   end
  end

  def thank_you
   @title='thank you!'
  end
  
private
 def populate_order
  for cart_item in @cart.cart_items
      order_item = OrderItem.new(
      :product_id => cart_item.product_id,
      :price => cart_item.product.price,
      :amount => cart_item.amount
   )
    @order.order_items << order_item
  end
end

end
