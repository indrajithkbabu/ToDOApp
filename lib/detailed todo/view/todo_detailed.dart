import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/add%20todo/cubit/addtodo_cubit.dart';
import 'package:todoapp/add%20todo/view/add_todo.dart';
import 'package:todoapp/model/todo_model.dart';

class DetailedTodoScreen extends StatelessWidget {
  const DetailedTodoScreen(
      {required this.todoItem, required this.index, super.key});
  final TodoModel todoItem;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<AddtodoCubitImpl, AddtodoState>(
      builder: (addTodoContext, addTodoState) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  todoItem.title,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(todoItem.description),
                const Spacer(),
                Row(
                  mainAxisAlignment: !todoItem.isCompleted
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    if (!todoItem.isCompleted)
                      ElevatedButton(
                          onPressed: () {
                            addTodoContext
                                .read<AddtodoCubitImpl>()
                                .completeTodo(index);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                    content:
                                        Text('Todo completed successfully')));
                          },
                          child: const Text('Complete todo')),
                    if (!todoItem.isCompleted)
                      ElevatedButton(
                          onPressed: () {
                            addTodoContext
                                .read<AddtodoCubitImpl>()
                                .toogleisEdit(isEdit: true);
                            addTodoContext
                                .read<AddtodoCubitImpl>()
                                .setIndex(index);
                            addTodoContext
                                .read<AddtodoCubitImpl>()
                                .resetField(index);

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTodoScreen(),
                                ));
                          },
                          child: const Text('Edit todo')),
                    ElevatedButton(
                        onPressed: () {
                          addTodoContext
                              .read<AddtodoCubitImpl>()
                              .deleteTodo(index);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Todo deleted'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ));
                        },
                        child: const Text('delete todo')),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
