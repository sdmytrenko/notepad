
class Memo < Post
	# Класс для написания заметок

	# В классе нет ничего дополнительного, чего бы не было в Post, поэтому нам не нужен конструктор
	# При создании обьекта класса Memo будет вызываться конструктор класса Post

	def read_from_console
		puts "Новая заметка (все, что написано до строчки \"end\"):"

		@text = []
		line = nil

		while line != "end" do
			line = STDIN.gets.chomp
			@text << line
		end

		@text.pop
	end

	def to_strings
		time_string = "Создано: #{@created_at.strftime("%Y-%m-%d, %H-%M-%S") } \n\r \n\r"

		return @text.unshift(time_string)
	end
end