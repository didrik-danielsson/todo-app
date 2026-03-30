import 'dart:io';

import '../models/Task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart' as api;

class Taskservice {

Future<List<Task>> getAllTasks() async {

    final http.Client client = http.Client();
    final String baseUrl = dotenv.get('BASE_URL');
    try {
        final Uri url = Uri.https(
            '$baseUrl/api/tasks'
        );
        final http.Response response = await client.get(url);
        if (response.statusCode == 200) {
            final Map<String, Object?> jsonData =
                jsonDecode(response.body) as Map<String, Object?>;
            return Task.listFromJson(jsonData);
        } else {
            throw HttpException('Something wrong'
            );
        }
    } on FormatException {
        rethrow;
    } finally {
        client.close();
    }
}

}