require 'json'
require 'yaml'
require 'date'

class ExpenseManager
  def initialize
    @expenses = {} 
    initialize_with_sample_expense
  end

  def add_expense(title, data)
    @expenses[title] = {
      amount: data[:amount],
      categories: data[:categories],
      payment_methods: data[:payment_methods],
      date: data[:date] || Date.today
    }
  end

  def initialize_with_sample_expense
     add_expense("Кава", {
      amount: 45,
      categories: ["Їжа", "Напої"],
      payment_methods: ["Готівка"],
      date: Date.today
    })
  end

  def edit_expense(title, data)
    if @expenses.key?(title)
      @expenses[title].merge!(data)
    else
      puts "Витрата '#{title}' не знайдена."
    end
  end

  def delete_expense(title)
    if @expenses.delete(title)
      puts "Витрату '#{title}' видалено."
    else
      puts "Витрата '#{title}' не знайдена."
    end
  end

  def find_expenses_by_title(title)
    @expenses[title]
  end

  def save_to_json(file_path)
    File.write(file_path, JSON.pretty_generate(@expenses))
  end

  def load_from_json(file_path)
    @expenses = JSON.parse(File.read(file_path), symbolize_names: true)
  end

  def save_to_yaml(file_path)
    File.write(file_path, YAML.dump(@expenses))
  end

  def load_from_yaml(file_path)
    raw_data = YAML.safe_load_file(file_path, permitted_classes: [Date, Symbol])
    @expenses = {}

    raw_data.each do |title, data|
      @expenses[title] = {
        amount: data[:amount],
        categories: data[:categories],
        payment_methods: data[:payment_methods],
        date: data[:date].is_a?(Date) ? data[:date] : Date.parse(data[:date].to_s)
      }
    end
  end

  def list_expenses
    @expenses.each do |title, exp|
      puts "Назва: #{title}"
      puts "Сума: #{exp[:amount]} грн"
      puts "Категорії: #{exp[:categories].join(', ')}"
      puts "Способи оплати: #{exp[:payment_methods].join(', ')}"
      puts "Дата: #{exp[:date]}"
      puts "-" * 40
    end
  end
end
