
class Task < Post
	# Класс отвечающий за написание ToDo списков

	def initialize
		super #внутри метода дочернего класса означает, дерни метод з таким же названием в родителя

		@due_date = Time.now
	end

	def read_from_console
	end

	def to_strings
	end
end