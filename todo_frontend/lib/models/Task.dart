import 'dart:convert';

class Task{

  final int? id;
  final String title;
  final String description;
  final bool completed;


  Task({this.id, required this.title, required this.description, this.completed = false, });


  factory Task.fromJson(Map<String, Object?> json) {

  }
}