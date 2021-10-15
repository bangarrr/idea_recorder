class Idea {
  Idea({required this.text, this.completed = false});
  final String text;
  bool completed;

  factory Idea.fromJson(Map<String, dynamic> json) => Idea(
    text: json['text'],
    completed: json['completed']
  );

  Map<String, dynamic> toJson() => {
    'text': text,
    'completed': completed
  };

  void toggleCompleted() {
    completed = !completed;
  }
}