module OrdersHelper
def get_setup_purchase_params(cart, request)
    return  {
      :ip => request.remote_ip,
      :return_url => orders_checkout_url,
      :cancel_return_url => products_url,
      :handling => 0,
      :tax => 0,
      :allow_note => true,
      :items => get_items(cart),
    }
  end

  def get_shipping(cart)
    # define your own shipping rule based on your cart here
    # this method should return an integer
  end

  def get_items(cart)
    cart.cart_items.collect do |line_item|
      product = line_item.product

      {
        :name => product.title,
        :number => product.id,
        :quantity => line_item.amount,
        
      }
    end
  end

  def get_totals(cart)
    cart.total
  end

end
