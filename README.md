# notepad
version.1.0
Simply notepad based on ruby

Блокнот должен уметь:
1. Делать простые заметки с текстом
2. Можно сохранить ссилку, добавить к ней описание
3. Поставить таски

1. Поля обьекта Memo:
@text --> Post
@created_at --> Post

2. Поля обьекта Link:
@url
@description (@text) --> Post
@created_at --> Post

3. Поля обьекта Task:
@created_at --> Post
@due_date
@text --> Post

Class Post
@text
@created_at
