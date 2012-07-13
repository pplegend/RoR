class CreateProductCategoryRelationships < ActiveRecord::Migration
  def self.up
    create_table :product_category_relationships do |t|
      t.integer :product_id
      t.integer :category_id

    end
  end

  def self.down
    drop_table :product_category_relationships
  end
end
