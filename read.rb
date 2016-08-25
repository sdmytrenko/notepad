# файл для прочтения с базы

require_relative 'post.rb' #подключить файл из той же директории
require_relative 'memo.rb'
require_relative 'task.rb'
require_relative 'link.rb'

#id, limit (последние N  записей), type

require 'optparse'

# Все наши опции будут записаны сюда
options = {}

OptionParser.new do |opt|
	# Ruby Blocks
	opt.banner = 'Usage: read.rb [options]' # помощь будет выведена, если пользователь ничего не ввел, или help

	opt.on('-h', 'Prints this help') do
		puts opt
		exit
	end

	opt.on('--type POST_TYPE', 'какой тип постов показывать (по умолчанию любой)') { |o| options[:type] = o }
	opt.on('--id POST_ID', 'если задан id - показываем подробно только этот пост') { |o| options[:id] = o }
	opt.on('--limit NUMBER', 'сколько последних постов показать (по умолчанию все)') { |o| options[:limit] = o }
	# Если в options добавляется ключ type 

end.parse!

# на выходе у нас есть асоциативный массив options с нужными ключами

result = Post.find(options[:limit], options[:type], options[:id])

# find будет возвращать, если передали id конкретный екземпляр одного с дочерних классов Post, 
# а если не передали, то массив хешей про все записи, которые он нашол по этим критериям

if result.is_a? Post # Если результат является классом Post то
	puts "Запись #{result.class.name}, id = #{options[:id]}" # Запись с таким именем класса с таким идентификатором

	result.to_strings.each do |line|
		puts line
	end
else # покажем таблицу резултьтатов в цикле, find тогда должен возвращать массив
	print "| id\t|   @type\t|   @created_at\t\t\t|   @text \t\t\t|   @url\t\t|   @due_date \t "

	result.each do |row| # Каждую строчку мы выводим на екран
		puts # обвиваем пустой строкой

		row.each do |element| # в этой строчке массив значений - проходим по нем и выводим внутри строки каждый елемент
			print "| #{element.to_s.delete("\\n\\r"[0..40])}\t" # значения отделяем |
						# выводим сам елемент.строковое представление если это текст многострочный (Мемо)
						# мы удаляем переносы строк "\\n\\r" и берем только первые 40 символов строки [0.. 40]
		end
	end
end

puts