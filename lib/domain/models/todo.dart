class Todo {
  int id;
  String text;
  bool isComplete;

  Todo({required this.id , required this.text, this.isComplete = false});

  Todo toggleComplition() => Todo(id: id, text: text, isComplete: !isComplete);
}
