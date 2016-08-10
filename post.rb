#Базовый родительский класс

class Post

	def initialize
		@created_at = Time.now #инициализация по текущему пользователю
		@text = nil #пустое, потому что каждый наследованый класс заполняет его своими данными
	end

	def read_from_console
		#Тут наши записи должны запрашивать ввод пользователя
		# todo
	end

	def to_strings
		#должен возвращать содержимое обьекта в виде массива строк
		# todo
	end

	def save
		#будет сохранять запись в файл
		#file_path - путь к файлу
		#to_strings - содержание файла

		file = File.new(file_path, "w:UTF-8")

		for item in to_strings do
			file.puts(item)
		end

		file.close
	end

	def file_path
		# путь к файлу, куда записывать содержимое обьекта

		current_path = File.dirname(__FILE__)
		file_name = @created_at.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S.txt")
		#берет время создания, при помощи метода .strftime превращает его в строку формата имя класса.дата.txt

		return current_path + "/" + file_name
	end
end