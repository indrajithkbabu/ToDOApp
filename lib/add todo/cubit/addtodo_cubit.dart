import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/model/todo_model.dart';

part 'addtodo_state.dart';

abstract class AddtodoCubit {
  void setTitle(String title);
  void setDescription(String description);
  void addTodo();
  void loadTodo();
  void saveTodoList(List<TodoModel> todoList);
  void deleteTodo(int index);
  void setIndex(int index);
  void completeTodo(int index);
  void toogleisEdit({bool isEdit});
  void resetField(int index);
  void editTodo();
  void clearData();
}

class AddtodoCubitImpl extends Cubit<AddtodoState> implements AddtodoCubit {
  AddtodoCubitImpl() : super(const AddtodoState()) {
    loadTodo();
  }

  @override
  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }

  @override
  void setTitle(String title) {
    emit(state.copyWith(title: title));
  }

  @override
  Future<void> addTodo() async {
    final tempList = List<TodoModel>.from(state.todoList);
    final box = await Hive.openBox<TodoModel>('todoBox');
    final newTodo = TodoModel(state.title, state.description, false);
    tempList.add(newTodo);
    await box.add(newTodo);
    emit(state.copyWith(todoList: tempList));
    await saveTodoList(tempList);
  }

  @override
  Future<void> saveTodoList(List<TodoModel> todoList) async {
    final box = await Hive.openBox<TodoModel>('todoBox');
    await box.clear();
    await box.addAll(todoList);
  }

  @override
  void loadTodo() async {
    final box = await Hive.openBox<TodoModel>('todoBox');
    final List<TodoModel> todoList = box.values.toList();
    emit(state.copyWith(
      todoList: todoList,
    ));
  }

  @override
  void deleteTodo(int index) async {
    final tempList = List<TodoModel>.from(state.todoList)..removeAt(index);
    emit(state.copyWith(
      todoList: tempList,
    ));
    await saveTodoList(tempList);
  }

  @override
  void completeTodo(int index)async {
    
   final TodoModel todoModel =state.todoList[index];
    final TodoModel todo = TodoModel(todoModel.title, todoModel.description,true);
  final tempList = List<TodoModel>.from(state.todoList);
      tempList[index] = todo;
      emit(state.copyWith(todoList: tempList,isCompleted: true));
      await saveTodoList(tempList);
  }

  @override
  void editTodo() async {
    final int? index = state.index;
    if (index != null) {
      final TodoModel newTodo = TodoModel(state.title, state.description,false);
      final tempList = List<TodoModel>.from(state.todoList);
      tempList[index] = newTodo;
      emit(state.copyWith(todoList: tempList));
      await saveTodoList(tempList);
    }
  }

  @override
  void setIndex(int index) {
    emit(state.copyWith(index: index));
  }

  @override
  void toogleisEdit({bool? isEdit}) {
    emit(state.copyWith(isEdit: isEdit));
  }

  @override
  void resetField(int index) {
    final tempList = List<TodoModel>.from(state.todoList);
    emit(state.copyWith(
      title: tempList[index].title,
      description: tempList[index].description,
    ));
  }

  @override
  void clearData() {
    emit(state.copyWith(
      title: '',
      description: '',
    ));
  }
}
