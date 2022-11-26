import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todolist/Controller/todo_list.controller.dart';
import 'package:todolist/strings.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
   final _controller = TodoListController();

   final _formKay = GlobalKey<FormState>();

   final TextEditingController todoController = TextEditingController();

   String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.APP_NAME),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Observer(
                builder: (_) => _controller.getAllTodo.isEmpty 
                  ? const Center(child:Text(Strings.TODO_LIST_EMPATY)) 
                    : ListView.builder(
                      itemCount: _controller.getAllTodo.length,
                      itemBuilder: (_, index) => Dismissible(
                        onDismissed: (direction) {
                          _controller.remove(index);
                        },
                        key: ValueKey(_controller.getAllTodo[index]),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white,),
                        ),
                        child: CheckboxListTile(
                          value: _controller.getAllTodo[index].isDone,
                          onChanged: (value) {
                            setState(() {
                              _controller.updateDone(index, value!);
                            });
                          },
                          title: Text(_controller.getAllTodo[index].title),
                        ),
                      ),
                    ),
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKay,
                      child: TextFormField(
                        controller: todoController,
                        onSaved: (newValue) => title = newValue!,
                        decoration: const InputDecoration(
                          labelText: Strings.TODO_FORM_TITLE,
                          border: OutlineInputBorder()
                        ),
                        validator: (value) {
                          if (value == null) return Strings.VALID_NOT_EMPTY;
                          if (value.isEmpty) return Strings.VALID_NOT_EMPTY;
                          if (value.length < 3) return Strings.VALID_TITLE_MIN_LENGTH;
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(height: 60,child: ElevatedButton(onPressed: (){
                    if(_formKay.currentState!.validate()){
                      _formKay.currentState!.save();
                      _controller.save(title);
                      todoController.clear();
                    }
                  }, child: const Icon(Icons.add)))
                ],
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}