import 'dart:io';
import '../models/Task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Taskservice {

    String get baseUrl => dotenv.get('BASE_URL');

Future<List<Task>> getAllTasks() async {

    try {
        final http.Response response = await http.get(Uri.parse('$baseUrl/api/tasks'));

        if (response.statusCode == 200) {
            final List<dynamic> jsonData = jsonDecode(response.body);
            print('Getting tasks worked great!!!');
            return Task.listfromJson(jsonData);
        } else {
            throw HttpException('Could not get tasks'
            );
        }
    } catch (e) {
        rethrow;
    }
}


Future<Task> createTask(Task newTask) async {

    try {

    final Uri url = Uri.parse('$baseUrl/api/tasks');

    final http.Response response = await http.post(
    url,
    headers: {
        'Content-type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(newTask.toJson()),
    );

    if (response.statusCode == 200) {
        print('Creating worked great!!!');
        return Task.fromJson(jsonDecode(response.body));
    } else {
        throw HttpException('Kunde inte skapa');
        }
    } catch (e) {
        rethrow;
    }
}


Future<void> deleteTask(int id) async {

    try {
        final Uri url = Uri.parse('$baseUrl/api/tasks/delete/${id}');

        final http.Response response = await http.delete(url);

        if (response.statusCode != 200) {
            throw HttpException('Kunde inte ta bort uppgiften');
        }
    } catch (e) {
        rethrow;
    }

}
}