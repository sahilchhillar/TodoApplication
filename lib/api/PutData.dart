import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_project/models/TodoData.dart';
import 'package:todo_project/service/Globals.dart';

class PutData {
  Future<TodoData> updateTask(String task, String id) async {
    final response = await http.put(Uri.parse(updateTasksURL + id),
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

  Future<TodoData> updatePending(String id) async {
    final response = await http.put(Uri.parse(updatePendingURL + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 201 || response.statusCode == 200) {
      return TodoData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create task.');
    }
  }
}