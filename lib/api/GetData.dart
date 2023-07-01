import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo_project/models/TodoData.dart';
import 'package:todo_project/service/Globals.dart';

class GetData {
  Future<List> getTasks() async {
    final response = await http.get(Uri.parse(getTasksURL));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      // print('Fetching data!!!');
      // print(result.toString());
      return result.map((e) => TodoData.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch data!!!");
    }
  }
}
