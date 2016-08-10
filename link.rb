
class Link < Post
	# Класс для сохранения ссылок

	def initialize
		super #внутри метода дочернего класса означает, дерни метод з таким же названием в родителя

		@url = ''
	end

	def read_from_console
		puts "Адрес ссылки"
		@url = STDIN.gets.chomp

		puts "Назва ссылки"
		@text = STDIN.gets.chomp
	end

	def to_strings
		time_string = "Создано: #{@created_at.strftime("%Y-%m-%d, %H-%M-%S") } \n\r \n\r"

		return [@url, @text, time_string]
	end
end