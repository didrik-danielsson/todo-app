import 'dart:convert';

class Task{

  final int? id;
  final String title;
  final String description;
  final bool completed;


  Task({this.id, required this.title, required this.description, this.completed = false, });


  factory Task.fromJson(Map<String, Object?> json) {
  return Task(
    id: json['id'] as int?,
    title: json['title'] as String,
    description: json['description'] as String,
    completed: json['completed'] as bool,
  );
  }

  Map<String, Object?> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }

  static List<Task> listfromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Task.fromJson(json)).toList();

  }
}