import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/add%20todo/cubit/addtodo_cubit.dart';
import 'package:todoapp/list%20todo/view/list_todo.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
void main() async{
     WidgetsFlutterBinding.ensureInitialized();
  final directory=await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>('todoBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddtodoCubitImpl(),
      child: MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ListTodoScreen(),
      ),
    );
  }
}
