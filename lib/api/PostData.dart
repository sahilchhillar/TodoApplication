import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_project/models/TodoData.dart';
import 'package:todo_project/service/Globals.dart';

class PostData {
  Future<TodoData> createTask(String task) async {
    final response = await http.post(Uri.parse(createURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'task': task, 'pending': true}));

    if (response.statusCode == 201 || response.statusCode == 200) {
      return TodoData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create task.');
    }
  }
}
