class AddOrderIdToCartItem < ActiveRecord::Migration
  def self.up
    add_column :cart_items, :order_id, :integer
  end

  def self.down
    remove_column :cart_items, :order_id
  end
end
