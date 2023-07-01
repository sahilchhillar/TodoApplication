import 'package:http/http.dart' as http;
import 'package:todo_project/service/Globals.dart';

class DeleteData {
  Future<http.Response> deleteAlbum(String id) async {
    final http.Response response = await http.delete(
      Uri.parse(deleteTaskURL + id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }
}
