class RemoveCartItemIdFromCart < ActiveRecord::Migration
  def self.up
   remove_column :carts,:cart_item_id
  end

  def self.down
   add_column :carts, :cart_item_id, :integer
  end
end
