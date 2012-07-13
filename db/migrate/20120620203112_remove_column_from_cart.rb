class RemoveColumnFromCart < ActiveRecord::Migration
  def self.up
   remove_column :carts, :quality
  end

  def self.down
   add_column :carts, :quality
  end
end
