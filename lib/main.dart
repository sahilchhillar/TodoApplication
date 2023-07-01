import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_project/api/DeleteData.dart';
import 'package:todo_project/api/GetData.dart';
import 'package:todo_project/api/PostData.dart';
import 'package:todo_project/api/PutData.dart';

void main() {
  runApp(const Todo());
}

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  _TodoApp createState() => _TodoApp();
}

class _TodoApp extends State<TodoApp> {
  late Future<List> todoData;

  @override
  void initState() {
    super.initState();
    // print('Inside init function');
    setState(() {
      todoData = GetData().getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('TODO'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 30),
          child: SizedBox(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              onPressed: () => _createPopupCard(' ', false, ''),
              backgroundColor: Colors.red,
              highlightElevation: 10,
              elevation: 10,
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
            child: FutureBuilder<List>(
              future: todoData,
              builder: (context, snapshot) {
                // print(snapshot);
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) => {
                                PutData().updatePending(
                                    snapshot.data![index].id.toString())
                              },
                              flex: 2,
                              backgroundColor: Colors.green,
                              icon: Icons.check,
                              label: 'Completed',
                            )
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              flex: 2,
                              onPressed: (context) => {
                                DeleteData().deleteAlbum(
                                    snapshot.data![index].id.toString()),
                                setState(() {
                                  todoData = GetData().getTasks();
                                })
                              },
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                            SlidableAction(
                              flex: 2,
                              onPressed: (context) => {
                                // print(snapshot.data![index].task.toString()),
                                _createPopupCard(
                                    snapshot.data![index].task.toString(),
                                    true,
                                    snapshot.data![index].id.toString()),
                              },
                              backgroundColor: Colors.green,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(snapshot.data![index].task.toString()),
                          trailing: Text(snapshot.data![index].pending
                              ? "Pending"
                              : "Completed"),
                          subtitle:
                              Text(snapshot.data![index].createdOn.toString()),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  // print("Hello World");
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            )));
  }

  Future<void> _createPopupCard(
      String defaultMessage, bool isUpdateEvent, String id) {
    final TextEditingController taskController =
        TextEditingController(text: defaultMessage);

    void sendAndUpdateTasks() {
      if (!isUpdateEvent) {
        PostData().createTask(taskController.text);
      } else {
        PutData().updateTask(taskController.text, id);
      }
      setState(() {
        todoData = GetData().getTasks();
      });
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: SizedBox(
              width: 300,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("Enter Task Details",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 15, right: 15, bottom: 40),
                    child: TextFormField(
                      enableInteractiveSelection: false,
                      controller: taskController,
                      keyboardType: TextInputType.text, // this is change
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Enter TODO task",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () =>
                                {sendAndUpdateTasks(), Navigator.pop(context)},
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () => {Navigator.pop(context)},
                            child: const Text(
                              "Discard",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
