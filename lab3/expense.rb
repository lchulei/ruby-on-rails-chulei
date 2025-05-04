require 'date'

class Expense
  attr_accessor :id, :amount, :description, :categories, :payment_methods, :date

  def initialize(id:, amount:, description:, categories:, payment_methods:, date: Date.today)
    @id = id
    @amount = amount
    @description = description
    @categories = categories
    @payment_methods = payment_methods
    @date = date
  end

  def to_hash
    {
      id: @id,
      amount: @amount,
      description: @description,
      categories: @categories,
      payment_methods: @payment_methods,
      date: @date.to_s
    }
  end

  def self.from_hash(hash)
    Expense.new(
      id: hash[:id],
      amount: hash[:amount],
      description: hash[:description],
      categories: hash[:categories],
      payment_methods: hash[:payment_methods],
      date: Date.parse(hash[:date].to_s)
    )
  end

  def to_s
    <<~EXPENSE
      ID: #{@id}
      Сума: #{@amount}
      Опис: #{@description}
      Категорії: #{@categories.join(', ')}
      Спосіб оплати: #{@payment_methods.join(', ')}
      Дата: #{@date}
    EXPENSE
  end
end
