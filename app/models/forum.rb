class Forum < ActiveRecord::Base
  has_many :topics, :dependent => :destroy
  belongs_to :user
  validates :user_id, :name,:description,:presence=>true
end
