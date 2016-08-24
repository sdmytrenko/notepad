
require_relative 'post.rb' #подключить файл из той же директории
require_relative 'memo.rb'
require_relative 'task.rb'
require_relative 'link.rb'

puts "Программа Блокнот v.2.0_Sqlite edition"
puts "Что вы хотите записать в блокнот?"

choices = Post.post_types.keys

choice = -1

until choice >=0 && choice < choices.size

	choices.each_with_index do |type, index| #each_with.index организирует цикл по всем элементам данного массива
		puts "\t#{index}, #{type}"
	end

	choice = STDIN.gets.chomp.to_i
end

entry = Post.create(choices[choice])

entry.read_from_console

id = entry.save_to_db

puts "Пост сохранен. id = #{id}"