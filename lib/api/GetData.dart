import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo_project/models/TodoData.dart';
import 'package:todo_project/service/Globals.dart';

class GetData {
  Future<List> getPendingTasks() async {
    final response = await http.get(Uri.parse(getPendingTasksURL));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => TodoData.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch data!!!");
    }
  }

  Future<List> getCompletedTasks() async {
    final response = await http.get(Uri.parse(getCompletedTasksURL));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => TodoData.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch data!!!");
    }
  }
}
