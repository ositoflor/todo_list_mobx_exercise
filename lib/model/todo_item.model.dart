import 'package:uuid/uuid.dart';

class TodoItem {
  String id = const Uuid().v4();
  String title = "";
  bool isDone = false;
  DateTime date = DateTime.now();

  TodoItem({this.title = "", this.isDone = false});

  TodoItem.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    isDone = json['is_done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['is_done'] = isDone;
    return data;
  }

  @override
  String toString() {
    return "TodoItem: $title,$isDone";
  }
  
}