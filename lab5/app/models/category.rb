class Category < ApplicationRecord
  has_many :categorizations
  has_many :expenses, through: :categorizations

  validates :name, presence: true, uniqueness: true
end
