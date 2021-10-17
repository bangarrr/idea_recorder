import 'package:random_string/random_string.dart';

class Idea {
  Idea({this.id, required this.text, DateTime? created_at, this.completed = false})
      : this.created_at = created_at ?? DateTime.now();

  String? id;
  String text;
  bool completed;
  DateTime created_at;

  factory Idea.fromJson(Map<String, dynamic> json) => Idea(
      id: json['id'],
      text: json['text'],
      completed: json['completed'],
      created_at: DateTime.parse(json['created_at'])
      );

  Map<String, dynamic> toJson() => {
        'id': id ?? randomAlphaNumeric(10),
        'text': text,
        'completed': completed,
        'created_at': created_at.toString()
      };

  void toggleCompleted() {
    completed = !completed;
  }
}
