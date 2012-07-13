class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.column :product_id, :integer
      t.column :order_id, :integer
      t.column :price, :float
      t.column :amount, :integer
      
      t.timestamps
    end
  end

  def self.down
    drop_table :order_items
  end
end
