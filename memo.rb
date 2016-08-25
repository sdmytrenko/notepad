
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

	def to_db_hash
		return super.merge(
			{
				'text' => @text.join('\n\r') # массив строк делаем одной большой строкой
			}
		)
	end

		# получает на вход хэш массив данных и должен заполнить свои поля
	def load_data(data_hash)
		super(data_hash) # сперва дергаем родительский метод для инициализации общих полей

		# теперь прописываем свое специфичное поле
		@text = data_hash['text'].split('\n\r')
		# поле парсим с базы по ключу
	end
end