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
      categories: @categories.map(&:name),
      payment_methods: @payment_methods.map(&:name),
      date: @date.to_s
    }
  end

  def self.from_hash(hash)
    Expense.new(
      id: hash[:id],
      amount: hash[:amount],
      description: hash[:description],
      categories: hash[:categories].map { |c| Category.new(c) },
      payment_methods: hash[:payment_methods].map { |pm| PaymentMethod.new(pm) },
      date: Date.parse(hash[:date].to_s)
    )
  end

  def to_s
    <<~EXPENSE
      ID: #{@id}
      Сума: #{@amount}
      Опис: #{@description}
      Категорії: #{@categories.map(&:name).join(', ')}
      Спосіб оплати: #{@payment_methods.map(&:name).join(', ')}
      Дата: #{@date}
    EXPENSE
  end
end
