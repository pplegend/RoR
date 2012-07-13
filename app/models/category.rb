class Category < ActiveRecord::Base
 validates :content, :uniqueness=>true
 has_many :product_category_relationships
 has_many :products, :through => :product_category_relationships
end
