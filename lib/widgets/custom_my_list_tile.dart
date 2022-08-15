import 'package:flutter/material.dart';
import 'package:flutter_to_do_app_hive_db/models/task_model.dart';
import 'package:flutter_to_do_app_hive_db/screens/task_editor.dart';

class CustomMyListTile extends StatefulWidget {
  Task task;
  int index;

  CustomMyListTile(this.task, this.index, {Key? key}) : super(key: key);

  @override
  State<CustomMyListTile> createState() => _CustomMyListTileState();
}

class _CustomMyListTileState extends State<CustomMyListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom: 12,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.task.title!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskEditor(
                        task: widget.task,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit_rounded,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.task.delete();
                },
                icon: Icon(
                  Icons.delete_rounded,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black87,
            height: 20,
            thickness: 1,
          ),
          Text(
            widget.task.note!,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
