class PaymentMethod < ApplicationRecord
  has_many :expense_payments
  has_many :expenses, through: :expense_payments

  validates :name, presence: true, uniqueness: true
end
