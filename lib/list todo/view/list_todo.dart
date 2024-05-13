import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/add%20todo/cubit/addtodo_cubit.dart';
import 'package:todoapp/add%20todo/view/add_todo.dart';
import 'package:todoapp/detailed%20todo/view/todo_detailed.dart';

class ListTodoScreen extends StatelessWidget {
  const ListTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Todo App'),
      ),
      body:  BlocBuilder<AddtodoCubitImpl, AddtodoState>(
            builder: (addTodoContext, addTodoState) {
                  return addTodoState.todoList.isEmpty
                      ? const Center(
                          child: Text('No todos added'),
                        )
                      : ListView.builder(
                          itemCount: addTodoState.todoList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailedTodoScreen(
                                      todoItem:  addTodoState.todoList[index],
                                        index: index,
                                      ),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: ListTile(
                                     
                                      title: Text(
                                        addTodoState.todoList[index].title,
                                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(addTodoState
                                          .todoList[index].description),
                                          trailing:addTodoState.todoList[index].isCompleted?const Icon(Icons.verified):const SizedBox() ,
                                     ),
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: () {
                  
                    context
                        .read<AddtodoCubitImpl>()
                        .toogleisEdit(isEdit: false);
                    context.read<AddtodoCubitImpl>().clearData();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  AddTodoScreen(),
                      ));
                },
                child: const Icon(Icons.add, color: Colors.white, size: 28),
              ),
    );
  }
}