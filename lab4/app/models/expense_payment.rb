class ExpensePayment < ApplicationRecord
  belongs_to :expense
  belongs_to :payment_method
end
