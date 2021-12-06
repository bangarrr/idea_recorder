import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class Task {
  Task({
    this.id,
    required this.text,
    this.scheduled_date,
    DateTime? created_at,
    this.completed = false
  }) : this.created_at = created_at ?? DateTime.now();

  String? id;
  String text;
  bool completed;
  DateTime? scheduled_date;
  DateTime created_at;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      id: json['id'],
      text: json['text'],
      scheduled_date: DateTime.tryParse(json['scheduled_date'] ?? 'null'),
      completed: json['completed'],
      created_at: DateTime.parse(json['created_at'])
      );

  Map<String, dynamic> toJson() => {
        'id': id ?? randomAlphaNumeric(10),
        'text': text,
        'completed': completed,
        'scheduled_date': scheduled_date.toString(),
        'created_at': created_at.toString()
      };

  void toggleCompleted() {
    completed = !completed;
  }

  String formattedScheduledDate() {
    return scheduled_date == null ? '' : DateFormat('yyyy/MM/dd').format(scheduled_date!);
  }
}
