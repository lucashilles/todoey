import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile(
      {this.isChecked, this.title, this.checkboxCallback, this.onLongPress});

  final bool isChecked;
  final String title;
  final Function checkboxCallback;
  final Function onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(25.0, 0, 10.0, 0),
      onLongPress: onLongPress,
      title: Text(
        '$title',
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
