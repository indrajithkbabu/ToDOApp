import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/add%20todo/cubit/addtodo_cubit.dart';
import 'package:todoapp/helpers/validation_helper.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({super.key});
  final FocusNode myFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocBuilder<AddtodoCubitImpl, AddtodoState>(
            builder: (addTodoContext, addTodoState) {
              return Form(
                key: formKey,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: ValidationHelper.validatetitle,
                        controller: TextEditingController.fromValue(
                            TextEditingValue(
                                text: addTodoState.title,
                                selection: TextSelection.fromPosition(
                                    TextPosition(
                                        offset: addTodoState.title.length)))),
                        onChanged: (value) {
                          addTodoContext
                              .read<AddtodoCubitImpl>()
                              .setTitle(value);
                        },
                        decoration: InputDecoration(
                            hintText: 'title',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 3,
                        validator: ValidationHelper.validateDescription,
                        controller: TextEditingController.fromValue(
                            TextEditingValue(
                                text: addTodoState.description,
                                selection: TextSelection.fromPosition(
                                    TextPosition(
                                        offset:
                                            addTodoState.description.length)))),
                        onChanged: (value) {
                          addTodoContext
                              .read<AddtodoCubitImpl>()
                              .setDescription(value);
                        },
                        decoration: InputDecoration(
                            hintText: 'description',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      
                      const SizedBox(
                        height: 20,
                      ),
                      addTodoState.isEdit
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      addTodoContext
                                          .read<AddtodoCubitImpl>()
                                          .editTodo();
                                      Navigator.pop(context);
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue),
                                  ),
                                  child: const Text(
                                    'Update todo',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    addTodoContext
                                        .read<AddtodoCubitImpl>()
                                        .addTodo();
                                    Navigator.pop(context);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                ),
                                child: const Text(
                                  'Add Todo',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
