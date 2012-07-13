class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :quality
      t.integer :cart_item_id

      t.timestamps
    end
  end

  def self.down
    drop_table :carts
  end
end
