class AddProductIdToRate < ActiveRecord::Migration
  def self.up
    add_column :rates, :product_id, :integer
  end

  def self.down
    remove_column :rates, :product_id
  end
end
