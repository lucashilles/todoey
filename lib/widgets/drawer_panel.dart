import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todoey/screens/add_tasklist_screen.dart';
import 'package:todoey/screens/tasklists_screen.dart';
import 'package:todoey/widgets/drawer_tasklists.dart';

class DrawerPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Do it, now!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            SwitchListTile(
              title: Text('Dark mode'),
              value: false,
              onChanged: (v) {},
            ),
            Divider(),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Text('Lists'),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton.icon(
                      color: Colors.lightBlue,
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Add List',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Color(0x00FFFFFF),
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => AddTaskListScreen(),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: RaisedButton.icon(
                      color: Colors.lightBlue,
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      label: Text(
                        'Edit Lists',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, TaskListsScreen.id);
                      },
                    ),
                  ),
                ],
              ),
            ),
            DrawerTaskLists(),
          ],
        ),
      ),
    );
  }
}

//SizedBox(
//width: 20.0,
//),
//                  RawMaterialButton(
//                    child: Icon(Icons.edit, size: 20.0, color: Colors.grey),
//                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                    constraints: BoxConstraints.tight(Size.fromRadius(15.0)),
//                    shape: CircleBorder(side: BorderSide.none),
//                    onPressed: () {
//                      Navigator.pushNamed(context, TaskListsScreen.id);
//                    },
//                  ),

//ListBody(
//children: <Widget>[
//ListTile(
//leading: Icon(Icons.label, size: 20.0),
//title: Text('Task List 1'),
//dense: true,
//selected: true,
//),
//ListTile(
//leading: Icon(Icons.label, size: 20.0),
//title: Text('Task List 2'),
//dense: true,
//),
//ListTile(
//leading: Icon(Icons.label, size: 20.0),
//title: Text('Task List 3'),
//dense: true,
//),
//],
//),
