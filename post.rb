# Базовый родительский класс
# Методы родительского класса, для которых не описана реализация принято называть  абстрактними  
require 'sqlite3'

class Post

	@@SQLITE_DB_FILE = 'notepad_base.sqlite' # переменная класса, хранит название базы данных

	def self.post_types #self.имя_метода - обьявление статического метода класса
		# переводим на исп. асоц. массива
		{'Memo' => Memo, 'Link' => Link, 'Task' => Task}
	end

	def self.create(type) # параметром будет индекс с массива [Memo, Link, Task]
		return post_types[type].new
	end

	def self.find(limit, type, id) #статический метод для поиска

		db = SQLite3::Database.open(@@SQLITE_DB_FILE)

		# 1. конкретная запись
		if !id.nil? # если параметр переданый в метод не нулевой
			db.results_as_hash = true

			result = db.execute("SELECT * FROM posts WHERE rowid = ?", id)
			# запрос дге плейсхолдер, второй параметр id который будет поставлен на место ? при обращении в базу

			result = result[0] if result.is_a? Array 
			# если результат массив то мы в result будем хранить первый елемент массива
			db.close

			if result.empty?
				puts "Такой id #{id} не найден в базе :("
				return nil
			else
				post = create(result['type']) # Post.create не пишем, бо create стат. метод того же класса
				# создаем новый екземпляр дочернего класса post и заполнить его в соотв.
				# с тем какие данные мы прочитали из базы

				post.load_data(result) # параметром будет асоциативный массив
				return post
			end
		else
			# 2. вернуть таблицу записей
			db.results_as_hash = false

			# формируем запрос в базу с нужными условиями
			query = "SELECT rowid, * FROM posts "
			query += "WHERE type = :type " unless type.nil? # добавить условие если тип не 0
			# :type - это плейсхолдер вместо ?
			query += "ORDER by rowid DESC" # достаем самые свежие данные
			query += "LIMIT :limit " unless limit.nil? # добавляем кол-во записей

			statement = db.prepare(query) # обьект готовый к выполнению

			statement.bind_param('type', type) unless type.nil?
			# с помощью метода bind_param передаем нашему подготовленому выражению то что было в type и
			# указываю в качестве 1го параметра имя плейсхолдера
			statement.bind_param('limit', limit) unless limit.nil?

			result = statement.execute! # получаем результат

			statement.close
			db.close

			return result
		end
	end


	def initialize
		@created_at = Time.now #инициализация по текущему пользователю
		@text = nil #пустое, потому что каждый наследованый класс заполняет его своими данными
	end

	def read_from_console
		#Тут наши записи должны запрашивать ввод пользователя
		# Абстрактный класс
	end

	def to_strings
		#должен возвращать представление содержимое обьекта в виде массива строк
		# Абстрактный класс
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

	def save_to_db
		db = SQLite3::Database.open(@@SQLITE_DB_FILE) # Открываем соединение к базе данных
		db.results_as_hash = true # чтобы результаты возвращались в виде асоциатывного массива

		db.execute(
			"INSERT INTO posts (" +
				to_db_hash.keys.join(',') +
				")" +
				"VALUES (" +
					('?,'*to_db_hash.keys.size).chomp(',') + # (?,?,?,?,?)
				")",
				to_db_hash.values
			)
		# Если все сработало, появляется новая запись в базе. Узнаем ее идентификатор
		insert_row_id = db.last_insert_row_id

		db.close

		return insert_row_id
	end

	def to_db_hash
		# абстрактный метод, который должен возвращать асоциативный массив 
		# со всеми полями данной записи где ключи - назвы полей
		{
			'type' => self.class.name,
			'created_at' => @created_at.to_s
		}
	end

	# получает на вход хэш массив данных и должен заполнить свои поля
	def load_data(data_hash)
		@created_at = Time.parse(data_hash['created_at'])
		# поле парсим с базы по ключу
	end
end