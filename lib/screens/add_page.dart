import 'package:flutter/material.dart';
import 'package:todolist/services/todo_services.dart';
import 'package:todolist/utils/snackbar_helper.dart';

class AddTodo extends StatefulWidget {
  final Map? todo;

  const AddTodo({
    super.key,
    this.todo,
  });

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final desc = todo['description'];
      titleController.text = title;
      descController.text = desc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Todo' : "Add Todo"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: descController,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(isEdit ? 'Update' : 'Submit'),
              ))
        ],
      ),
    );
  }

  void updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print("You cannot call update without todo data");
      return;
    }
    final id = todo['_id'];
    // final title = titleController.text;
    // final desc = descController.text;

    // final body = {"title": title, "description": desc, "is_completed": false};
    final isSucess = await TodoServices.updateTodo(id, body);
    if (isSucess) {
      showSucessMessage(context, "Update Success");
    } else {
      showErrorMessage(context, "Update Failed");
    }
  }

  void submitData() async {
    // final title = titleController.text;
    // final desc = descController.text;

    // final body = {"title": title, "description": desc, "is_completed": false};

    final isSucess = await TodoServices.addTofo(body);
    if (isSucess) {
      titleController.text = '';
      descController.text = '';
      showSucessMessage(context, "Creation Sucess");
    } else {
      showErrorMessage(context, "Creation Failed");
    }
  }

  Map get body {
    final title = titleController.text;
    final desc = descController.text;

    return {"title": title, "description": desc, "is_completed": false};
  }
}
