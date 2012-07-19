class Topic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many :posts, :dependent => :destroy
  validates :user_id, :name, :description, :presence=>true
  
  
  def self.search(search)
    search_condition="%" + search + "%"
    find(:all, :conditions=>['name LIKE ? OR description LIKE ?', search_condition, search_condition])
  end
end
