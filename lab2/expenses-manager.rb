require 'json'
require 'yaml'
require 'date'

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

    @expenses << {
      id: @next_id,
      amount: amount,
      description: description,
      categories: categories,
      payment_methods: payment_methods,
      date: date
    }
    @next_id += 1
    puts "Витрату додано!"
  end

  def list_expenses
    if @expenses.empty?
      puts "Немає витрат."
    else
      @expenses.each do |e|
        puts "ID: #{e[:id]}"
        puts "Сума: #{e[:amount]},"
        puts "Опис: #{e[:description]}"
        puts "Категорії: #{e[:categories].join(', ')}"
        puts "Спосіб оплати: #{e[:payment_methods].join(', ')}"
        puts "Дата: #{e[:date]}"
        puts "-" * 40
      end
    end
  end

  def edit_expense
    print "Введіть ID витрати для редагування: "
    id = gets.to_i
    expense = @expenses.find { |e| e[:id] == id }

    if expense
      print "Нова сума (залишити порожнім, щоб не змінювати): "
      input = gets.chomp
      expense[:amount] = input.to_f unless input.empty?

      print "Новий опис: "
      input = gets.chomp
      expense[:description] = input unless input.empty?

      print "Нові категорії: "
      input = gets.chomp
      expense[:categories] = input.split(',').map(&:strip) unless input.empty?

      print "Нові способи оплати: "
      input = gets.chomp
      expense[:payment_methods] = input.split(',').map(&:strip) unless input.empty?

      puts "Витрату оновлено!"
    else
      puts "Витрата не знайдена."
    end
  end

  def delete_expense
    print "Введіть ID витрати для видалення: "
    id = gets.to_i
    if @expenses.reject! { |e| e[:id] == id }
      puts "Витрату видалено!"
    else
      puts "Витрата не знайдена."
    end
  end

  def save_to_file_json
    File.write("expenses.json", JSON.pretty_generate(@expenses))
    puts "Дані збережено у файл expenses.json"
  end

  def load_from_file_json
    if File.exist?("expenses.json")
      @expenses = JSON.parse(File.read("expenses.json"), symbolize_names: true)
      @next_id = @expenses.map { |e| e[:id] }.max.to_i + 1
      puts "Дані завантажено з файлу."
    else
      puts "Файл не знайдено."
    end
  end

  def save_to_file_yaml
    File.write("expenses.yaml", YAML.dump(@expenses))
    puts "Дані збережено у файл expenses.yaml"
  end

  def load_from_file_yaml
    if File.exist?("expenses.yaml")
      @expenses = YAML.load_file("expenses.yaml")
      @next_id = @expenses.map { |e| e[:id] }.max.to_i + 1
      puts "Дані завантажено з файлу."
    else
      puts "Файл не знайдено."
    end
  end
end
