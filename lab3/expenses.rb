require_relative 'expenses-manager'

manager = ExpenseManager.new

loop do
  puts "===========Виберіть операцію============"
  puts "1. Переглянути витрати"
  puts "2. Додати витрату"
  puts "3. Редагувати витрату"
  puts "4. Видалити витрату"
  puts "5. Зберегти у файл JSON"
  puts "6. Завантажити з файлу JSON"
  puts "7. Зберегти у файл YAML"
  puts "8. Завантажити з файлу YAML"
  puts "0. Вихід"
  print "Ваш вибір: "
  choice = gets.to_i
  puts "===========Виконання операції==========="

  case choice
  when 1 then manager.list_expenses
  when 2 then manager.add_expense
  when 3 then manager.edit_expense
  when 4 then manager.delete_expense
  when 5 then manager.save_to_file_json
  when 6 then manager.load_from_file_json
  when 7 then manager.save_to_file_yaml
  when 8 then manager.load_from_file_yaml
  when 0 then break
  else puts "Невірний вибір. Спробуйте ще раз."
  end
end

puts "Роботу завершено!"