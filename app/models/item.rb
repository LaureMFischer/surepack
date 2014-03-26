class Item < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :lists
  validates_uniqueness_of :item_name

  CATEGORIES = ["Clothing", "Accessories", "Shoes", "Toiletries", "Electronics", "Miscellaneous"]
end
