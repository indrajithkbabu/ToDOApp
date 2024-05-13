// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addtodo_cubit.dart';

class AddtodoState extends Equatable {
  const AddtodoState(
      {this.title = '',
      this.description = '',
      this.todoList = const [],
      this.isCompleted = false,
      this.isEdit = false,
      this.index});
  final String title;
  final String description;
  final List<TodoModel> todoList;
  final bool isCompleted;
  final bool isEdit;
  final int? index;
  @override
  List<Object?> get props =>
      [title, description, todoList, isCompleted, isEdit, index];

  AddtodoState copyWith(
      {String? title,
      String? description,
      List<TodoModel>? todoList,
      bool? isCompleted,
      bool? isEdit,
      int? index}) {
    return AddtodoState(
      title: title ?? this.title,
      description: description ?? this.description,
      todoList: todoList ?? this.todoList,
      isCompleted: isCompleted ?? this.isCompleted,
      isEdit: isEdit ?? this.isEdit,
      index: index ?? this.index,
    );
  }
}
