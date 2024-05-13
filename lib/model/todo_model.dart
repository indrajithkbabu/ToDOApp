import 'package:hive/hive.dart';
 part 'todo_model.g.dart';
@HiveType(typeId: 0)
class TodoModel{
  TodoModel(this.title,this.description,this.isCompleted);
  @HiveField(0)
 final String title;
 @HiveField(1)
 final String description;
 @HiveField(2)
 final bool isCompleted;
}