class TodoData {
  final String id;
  final String task;
  final bool pending;
  final String createdOn;

  TodoData(
      {required this.id,
      required this.task,
      this.pending = true,
      this.createdOn = ""});

  factory TodoData.fromJson(Map<String, dynamic> json) {
    return TodoData(
        id: json['id'],
        task: json['task'],
        pending: json['pending'],
        createdOn: json['createdOn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task'] = task;
    data['pending'] = pending;
    data['createdOn'] = createdOn;
    return data;
  }
}
