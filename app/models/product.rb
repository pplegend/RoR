class Product < ActiveRecord::Base
 #https://github.com/mbleigh/acts-as-taggable-on
  acts_as_taggable_on :tags
  has_attached_file :image, :styles=>{:medium=>"300x300>", :thumb=>"100x100>"}
  has_many :product_category_relationships
  has_many :categories, :through => :product_category_relationships
  has_many :carts, :through=>:cart_items
  has_many :cart_items
  has_many :rates
  has_many :comments
end
