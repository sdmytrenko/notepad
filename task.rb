require 'date'

class Task < Post
	# Класс отвечающий за написание ToDo списков

	def initialize
		super #внутри метода дочернего класса означает, дерни метод з таким же названием в родителя

		@due_date = Time.now
	end

	def read_from_console
		puts "Что надо сделать?"
		@text = STDIN.gets.chomp

		puts "К какому числу? Укажите дату в формате дд.мм.гггг (10.08.2016)"
		input = STDIN.gets.chomp

		@due_date = Date.parse(input)
	end

	def to_strings
		time_string = "Создано: #{@created_at.strftime("%Y-%m-%d, %H-%M-%S") } \n\r \n\r"

		deadline = "Крайний строк: #{@due_date}"

		return [deadline, @text, time_string]
	end
end