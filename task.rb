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

	def to_db_hash
		# super - вызываю такой же метод но у родительского класса
		# {'a' => 1}.merge({'b' => 2}) == {'a' => 1, 'b' => 2}
		return super.merge(
						{
							'text' => @text,
							'due_date' => @due_date.to_s
						}
		)
	end

	def load_data(data_hash)
		super(data_hash) # сперва дергаем родительский метод для инициализации общих полей

		# теперь прописываем свое специфичное поле
		@due_date = Data.parce(data_hash['due_date'])
		# поле парсим с базы по ключу
	end
end