import 'package:flutter/material.dart';
import 'package:flutter_to_do_app_hive_db/main.dart';
import 'package:flutter_to_do_app_hive_db/models/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskEditor extends StatefulWidget {
  Task? task;

  TaskEditor({this.task, Key? key}) : super(key: key);

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _taskTitle = TextEditingController(
      text: widget.task == null ? null : widget.task!.title!,
    );
    TextEditingController _taskNote = TextEditingController(
      text: widget.task == null ? null : widget.task!.note!,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          widget.task == null ? 'Add a new task' : 'Update your task',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Task\'s Title',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: _taskTitle,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade50.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Your Task Title',
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Your Task\'s Note',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 25,
              controller: _taskNote,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade50.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Write Some Task Note',
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: RawMaterialButton(
                    onPressed: () async {
                      var newTask = Task(
                        title: _taskTitle.text,
                        note: _taskNote.text,
                        creation_date: DateTime.now(),
                        done: false,
                      );

                      Box<Task> taskBox = Hive.box<Task>('tasks');

                      if (widget.task != null) {
                        widget.task!.title = newTask.title;
                        widget.task!.note = newTask.note;
                        widget.task!.save();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      } else {
                        await taskBox.add(newTask);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }
                    },
                    fillColor: Colors.blueAccent.shade700,
                    child: Text(
                      widget.task == null ? 'Add New Task' : 'Update Task',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
