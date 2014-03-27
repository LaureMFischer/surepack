class List < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :items
  validates_uniqueness_of :name, scope: :user
end
