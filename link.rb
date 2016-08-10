
class Link < Post
	# Класс для сохранения ссылок

	def initialize
		super #внутри метода дочернего класса означает, дерни метод з таким же названием в родителя

		@url = ''
	end

	def read_from_console
	end

	def to_strings
	end
end