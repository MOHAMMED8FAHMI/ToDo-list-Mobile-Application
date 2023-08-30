import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/Data/database.dart';
import 'package:todo_app/Pages/dialog_box.dart';
import 'package:todo_app/Pages/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  reference the hive box
  final _myBox = Hive.box('NewBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // TODO: implement initState

    //if this is the first time ever openeing the app than create defult data
    if (_myBox.get("TODOLIST") == Null) {
      db.createInitialDate();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // list of todo tasks
/*  List db.toDoList = [
    ["Flutter Course", false],
    ["Maintain application", false],
  ];*/

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDolist.removeAt(index);
    });
    db.updateDatabase();
  }

  //text controller
  final _controller = TextEditingController();

  // checkbos was tapped
  void checkBoxChnaged(bool? value, int index) {
    setState(() {
      db.toDolist[index][1] = !db.toDolist[index][1];
    });
    db.updateDatabase();
  }

  // save new task

  void saveNewTask() {
    setState(() {
      db.toDolist.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00CCFF),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF3366FF),
                Color(0xFF00CCFF),
              ],
              begin: FractionalOffset(0.0, 2.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF3366FF),
      ),
      body: ListView.builder(
          itemCount: db.toDolist.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDolist[index][0],
              taskCompleted: db.toDolist[index][1],
              onChanged: (value) => checkBoxChnaged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }

          /*  children: [
            ToDoTile(
              taskName: "programming ",
              taskCompleted: true,
              onChanged: (p0) {},
            ),
            ToDoTile(
              taskName: "Flutter course ",
              taskCompleted: true,
              onChanged: (p0) {},
            ),

          ],*/

          ),
    );
  }
}
