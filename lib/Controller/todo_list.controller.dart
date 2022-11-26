import 'package:mobx/mobx.dart';
import 'package:todolist/model/todo_item.model.dart';

part 'todo_list.controller.g.dart';

class TodoListController = TodoListControllerBase with _$TodoListController;

abstract class TodoListControllerBase with Store {
  final List<TodoItem> _listTodo = ObservableList<TodoItem>.of([]);

  List<TodoItem> get getAllTodo => _listTodo;

  @action
  save(String newValue) {
    _listTodo.add(TodoItem(title: newValue));
  }

  @action 
  updateDone(int index, bool newValue) {
    _listTodo[index].isDone = newValue;
  }

  @action 
  remove(int index){
    _listTodo.removeAt(index);
  }

}