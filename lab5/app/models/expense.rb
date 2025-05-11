class Expense < ApplicationRecord
  has_many :categorizations
  has_many :categories, through: :categorizations

  has_many :expense_payments
  has_many :payment_methods, through: :expense_payments

  validates :amount, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :spendAt, presence: true
end
