require 'json'
require 'yaml'
require_relative 'expense'

class ExpenseManager
  def initialize
    @expenses = []
    @next_id = 1
  end

  def add_expense
    print "Сума: "
    amount = gets.to_f
    print "Опис: "
    description = gets.chomp
    print "Категорії (через кому): "
    categories = gets.chomp.split(',').map(&:strip)
    print "Способи оплати (через кому): "
    payment_methods = gets.chomp.split(',').map(&:strip)
    print "Дата (YYYY-MM-DD, залишити порожнім для сьогодні): "
    date_input = gets.chomp
    date = date_input.empty? ? Date.today : Date.parse(date_input)

    expense = Expense.new(
      id: @next_id,
      amount: amount,
      description: description,
      categories: categories,
      payment_methods: payment_methods,
      date: date
    )
    @expenses << expense
    @next_id += 1
    puts "Витрату додано!"
  end

  def list_expenses
    if @expenses.empty?
      puts "Немає витрат."
    else
      @expenses.each do |e|
        puts e.to_s
        puts "-" * 40
      end
    end
  end

  def edit_expense
    print "ID витрати: "
    id = gets.to_i
    expense = @expenses.find { |e| e.id == id }

    if expense
      print "Нова сума: "
      input = gets.chomp
      expense.amount = input.to_f unless input.empty?

      print "Новий опис: "
      input = gets.chomp
      expense.description = input unless input.empty?

      print "Нові категорії: "
      input = gets.chomp
      expense.categories = input.split(',').map(&:strip) unless input.empty?

      print "Нові способи оплати: "
      input = gets.chomp
      expense.payment_methods = input.split(',').map(&:strip) unless input.empty?

      puts "Витрату оновлено!"
    else
      puts "Витрата не знайдена."
    end
  end

  def delete_expense
    print "ID для видалення: "
    id = gets.to_i
    if @expenses.reject! { |e| e.id == id }
      puts "Витрату видалено!"
    else
      puts "Витрата не знайдена."
    end
  end

  def save_to_file_json
    File.write("expenses.json", JSON.pretty_generate(@expenses.map(&:to_hash)))
    puts "Дані збережено у файл expenses.json"
  end

  def load_from_file_json
    if File.exist?("expenses.json")
      data = JSON.parse(File.read("expenses.json"), symbolize_names: true)
      @expenses = data.map { |e| Expense.from_hash(e) }
      @next_id = @expenses.map(&:id).max.to_i + 1
      puts "Дані завантажено з файлу JSON."
    else
      puts "Файл не знайдено."
    end
  end

  def save_to_file_yaml
    File.write("expenses.yaml", YAML.dump(@expenses.map(&:to_hash)))
    puts "Дані збережено у файл expenses.yaml"
  end

  def load_from_file_yaml
    if File.exist?("expenses.yaml")
      data = YAML.load_file("expenses.yaml")
      @expenses = data.map { |e| Expense.from_hash(e.transform_keys(&:to_sym)) }
      @next_id = @expenses.map(&:id).max.to_i + 1
      puts "Дані завантажено з файлу YAML."
    else
      puts "Файл не знайдено."
    end
  end
end
