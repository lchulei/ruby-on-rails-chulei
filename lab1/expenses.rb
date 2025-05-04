require_relative 'expenses-manager'

manager = ExpenseManager.new

expense = {
  "Покупка ноутбука" => {
    amount: 32000,
    categories: ["Техніка", "Робота"],
    payment_methods: ["Картка"],
    date: Date.new(2025, 5, 2)
  }
}

expense1 = {
  "Похід в кіно" => {
    amount: 150,
    categories: ["Розваги"],
    payment_methods: ["Готівка"],
    date: Date.new(2025, 5, 3)
  }
}

puts "Витрати:"
puts "=========================="
manager.add_expense(expense.keys.first, expense.values.first)
manager.add_expense(expense1.keys.first, expense1.values.first)
manager.list_expenses
puts "=========================="
puts "Редагування витрат:"
puts "=========================="
manager.edit_expense(expense.keys.first, { amount: 30000, categories: ["Техніка"] })
manager.list_expenses
puts "=========================="
puts "Збереження витрат у JSON:"
puts "=========================="
manager.save_to_json("expenses.json")
puts "=========================="
puts "Видалення витрат:"
puts "=========================="
manager.delete_expense(expense1.keys.first)
puts "=========================="
manager.list_expenses
puts "=========================="
puts "Збереження витрат у YAML:"
puts "=========================="
manager.save_to_yaml("expenses.yaml")
puts "=========================="
puts "Зчитування витрат з JSON:"
puts "=========================="
manager.load_from_json("expenses.json")
manager.list_expenses
puts "=========================="
puts "Зчитування витрат з YAML:"
puts "=========================="
manager.load_from_yaml("expenses.yaml")
manager.list_expenses
puts "=========================="
