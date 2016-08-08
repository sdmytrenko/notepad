# notepad
version.1.0
Simply notepad based on ruby

Блокнот должен уметь:
1. Делать простые заметки с текстом
2. Можно сохранить ссилку, добавить к ней описание
3. Поставить таски

1. Поля обьекта Memo:\n
@text --> Post\n
@created_at --> Post\n

2. Поля обьекта Link:\n
@url\n
@description (@text) --> Post\n
@created_at --> Post\n

3. Поля обьекта Task:\n
@created_at --> Post\n
@due_date\n
@text --> Post\n

Class Post
@text
@created_at
