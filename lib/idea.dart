import 'package:random_string/random_string.dart';

class Idea {
  Idea({this.id, required this.text, this.completed = false});

  String? id;
  String text;
  bool completed;

  factory Idea.fromJson(Map<String, dynamic> json) =>
      Idea(
          id: json['id'],
          text: json['text'],
          completed: json['completed']
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id ?? randomAlphaNumeric(10),
        'text': text,
        'completed': completed
      };

  void toggleCompleted() {
    completed = !completed;
  }
}